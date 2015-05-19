class User <ActiveRecord::Base

validates(:first_name, :presence => true)

validates(:last_name, :presence => true)

validates(:email, :presence => true)

validates(:description, :presence => true)
validates :description, length: { maximum: 500 }

validates(:programmer_rating, :presence => true)

before_validation(:titleize_first_name)
before_validation(:titleize_last_name)

  define_method(:prog_match) do |second_user|
    total_points = 0
    if self.programmer_rating==(second_user.programmer_rating)
      total_points = 5
    elsif self.programmer_rating==(second_user.programmer_rating + 1) || self.programmer_rating==(second_user.programmer_rating - 1)
      total_points = 3
    elsif self.programmer_rating==(second_user.programmer_rating + 2) || self.programmer_rating==(second_user.programmer_rating - 2)
      total_points = 1
    else
      total_points = 0
    end
    total_points
  end
    # commented out until db is updated to have project_rating column.
  # define_method(:project_match) do |second_user|
  #   if self.project_rating==(second_user.project_rating)
  #     "great"
  #   elsif self.project_rating==(second_user.project_rating + 1) || self.project_rating==(second_user.project_rating - 1)
  #     "good"
  #   elsif self.project_rating==(second_user.project_rating + 2) || self.project_rating==(second_user.project_rating - 2)
  #     "okay"
  #   else
  #     "bad"
  #   end
  #
  # end
  #
  # define_method(:pace_match) do |second_user|
  #   if self.pace_rating==(second_user.pace_rating)
  #     "great"
  #   elsif self.pace_rating==(second_user.pace_rating + 1) || self.pace_rating==(second_user.pace_rating - 1)
  #     "good"
  #   elsif self.pace_rating==(second_user.pace_rating + 2) || self.pace_rating==(second_user.pace_rating - 2)
  #     "okay"
  #   else
  #     "bad"
  #   end
  # end

  define_method(:match) do |second_user|
    total_points = self.prog_match(second_user)
    total_points = total_points + self.project_match(second_user)
    # total_points = total_points + self.pace_match(second_user)
    if total_points >= 3
      "good match"
    else
      "not a good match"
    end
  end



  private

  define_method(:titleize_first_name) do
    self.first_name = (first_name().titleize())
  end

  define_method(:titleize_last_name) do
    self.last_name = (last_name().titleize())
  end
end
