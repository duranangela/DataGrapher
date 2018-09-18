class GraphService
  attr_reader :location, :characteristics

  def initialize(location, characteristics)
    @location = location
    @characteristics = characteristics
  end

  def total
    if @characteristics == 'Voter Data'
      if location == 'United States'
        VoterDatum.where(state: 'US').where(age: 'Total').first.total.delete(",").to_i * 1000
      else
        VoterDatum.where(state: location.upcase).where(age: 'Total').first.total.delete(",").to_i * 1000
      end
    else
      JSON.parse(total_response.body)[1][1]
    end
  end

  def labels
    if @characteristics == 'State'
      JSON.parse(states_response.body).map do |state|
        state[0]
      end.drop(1)
    elsif @characteristics == 'Age'
      JSON.parse(age_response.body).map do |age|
        AgeGroup.find_by(ref_num: (age[2])).group
      end.drop(1)
    elsif @characteristics == 'Voter Data'
      ['18-24', '25-34', '35-44', '45-64', '65+']
    # elsif @characteristics == 'Race'
    #   JSON.parse(race_response.body).map do |race|
    #     RaceGroup.find_by(ref_num: (race[3])).group
    #   end.drop(1)
    end
  end

  def pops
    if @characteristics == 'State'
      JSON.parse(states_response.body).map do |state|
        state[1]
      end.drop(1)
    elsif @characteristics == 'Age'
      JSON.parse(age_response.body).map do |age|
        age[1]
      end.drop(1)
    elsif @characteristics == 'Voter Data'
      if location == 'United States'
        VoterDatum.where(state: 'US').pluck(:total).map do |num|
          num.delete(",").to_i * 1000
        end
      else
        VoterDatum.where(state: location.upcase).pluck(:total).map do |num|
          num.delete(",").to_i * 1000
        end
      end.drop(1)
    # elsif @characteristics == 'Race'
    #   JSON.parse(race_response.body).map do |race|
    #     race[1]
    #   end.drop(1)
    end
  end

  def popsb
    if @characteristics == 'Voter Data'
      if location == 'United States'
        VoterDatum.where(state: 'US').pluck(:registered).map do |num|
          num.delete(",").to_i * 1000
        end
      else
        VoterDatum.where(state: location.upcase).pluck(:registered).map do |num|
          num.delete(",").to_i * 1000
        end
      end.drop(1)
    else
      nil
    end
  end

  def popsc
    if @characteristics == 'Voter Data'
      if location == 'United States'
        VoterDatum.where(state: 'US').pluck(:voted).map do |num|
          num.delete(",").to_i * 1000
        end
      else
        VoterDatum.where(state: location.upcase).pluck(:voted).map do |num|
          num.delete(",").to_i * 1000
        end
      end.drop(1)
    else
      nil
    end
  end

  def total_response
    conn.get("?", total_params)
  end

  def states_response
    conn.get("?get=GEONAME,POP&for=state:*&DATE=10&key=#{ENV['API_KEY']}")
  end

  def age_response
    conn.get("?", age_params)
  end

  # def race_response
  #   conn.get("?", race_params)
  # end

  def conn
    Faraday.new(url: "https://api.census.gov/data/2017/pep/charagegroups") do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def total_params
    if @location == 'United States'
      loc = 'us:*'
    else
      loc_num = StateName.find_by(name: @location).fips
      loc = "state:#{loc_num}"
    end
    {
      get: 'GEONAME,POP',
      for: loc,
      key: ENV['API_KEY']
    }
  end

  # def race_params
  #   if @location == 'United States'
  #     loc = 'us:*'
  #   else
  #     loc_num = StateName.find_by(name: @location).fips
  #     loc = "state:#{loc_num}"
  #   end
  #   {
  #     get: 'GEONAME,POP',
  #     for: loc,
  #     'DATE' => 10,
  #     'RACE' => '1,2,3,4,5,6',
  #     key: ENV['API_KEY']
  #   }
  # end

  def age_params
    if @location == 'United States'
      loc = 'us:*'
    else
      loc_num = StateName.find_by(name: @location).fips
      loc = "state:#{loc_num}"
    end
    {
      get: 'GEONAME,POP',
      for: loc,
      'DATE' => 10,
      'AGEGROUP' => '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18',
      key: ENV['API_KEY']
    }
  end

end
