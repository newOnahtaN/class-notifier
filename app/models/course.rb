class Course

  attr_accessor :crn
  attr_accessor :course_id
  attr_accessor :course_attributes
  attr_accessor :title
  attr_accessor :instructor
  attr_accessor :credit_hours
  attr_accessor :meet_days 
  attr_accessor :meet_times
  attr_accessor :proj_enr
  attr_accessor :curr_enr
  attr_accessor :seats_available
  attr_accessor :status
  
  def initialize table_row
    return unless table_row.present?
    @crn = table_row[0].text
    @course_id = table_row[1].text
    @course_attributes = table_row[2].text
    @title = table_row[3].text
    @instructor = table_row[4].text
    @credit_hours = table_row[5].text
    @meet_days  = table_row[6].text
    @meet_times = table_row[7].text
    @proj_enr = table_row[8].text
    @curr_enr = table_row[9].text
    @seats_available = table_row[10].text
    @status = table_row[11].text
  end

  def to_s
    @crn + ': ' + @title + 'with  ' + @instructor
  end

  def ==(another_course)
    @crn == another_course.crn
  end
end
