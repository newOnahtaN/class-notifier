class Course 

  attr_accessor :crn, :course_id, :course_attributes, :title, :instructor, :credit_hours,
                :meet_days, :meet_times, :proj_enr, :curr_enr, :seats_available, :status
  
  def initialize table_row
    return unless table_row.present?
    @crn = table_row[0]
    @course_id = table_row[1]
    @course_attributes = table_row[2]
    @title = table_row[3]
    @instructor = table_row[4]
    @credit_hours = table_row[5]
    @meet_days  = table_row[6]
    @meet_times = table_row[7]
    @proj_enr = table_row[8]
    @curr_enr = table_row[9]
    @seats_available = table_row[10]
    @status = table_row[11]
  end

  def to_s
    "#{@crn}: #{@course_id} (#{@title}) with #{@instructor} at #{@meet_times} on #{@meet_days}. Seats available #{@seats_available}"
  end

  def ==(another_course)
    @crn == another_course.crn
  end
end
