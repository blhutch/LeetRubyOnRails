class Layover < ActiveRecord::Base
  belongs_to :user

def meetup
    @layover = Layover.find(params[:id])
    arrival_overlaps = Layover.where(short_name: @layover.short_name).
      where("arrival_time <= ? AND dept_time >= ?",
        @layover.arrival_time, @layover.arrival_time + 2.hours)
    departure_overlaps = Layover.where(short_name: @layover.short_name).
      where("arrival_time <= ? AND dept_time >= ?",
        @layover.dept_time - 2.hours, @layover.dept_time)
    @overlaps = (arrival_overlaps + departure_overlaps).uniq
    if @overlaps = nil
      render json: { message: 'There is no one available to meetup.' },
        status: :no_content
    else
      render 'overlaps.json.jbuilder', status: :created
    end
  end

end
