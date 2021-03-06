defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.CreateOrUpdate, as: BookingCoU

  def generate(filename \\ "report_bookings.csv") do
    File.write(filename, "")

    BookingCoU.get_all()
    |> Map.values()
    |> Enum.map(&booking_str(&1))
    |> Enum.each(&add_in_report(&1,filename))
  end

  defp booking_str(%Booking{user_id: user_id,
                            local_origin: local_origin,
                            local_destination: local_destination,
                            complete_date: complete_date})
  do
    "#{user_id},#{local_origin},#{local_destination},#{complete_date}\n"
  end

  # defp booking_str(%Booking{id: id,
  #                           user_id: user_id,
  #                           local_origin: local_origin,
  #                           local_destination: local_destination,
  #                           complete_date: complete_date})
  # do
  #   "#{id}, #{user_id}, #{local_origin}, #{local_destination}, #{complete_date}\n"
  # end

  defp add_in_report(report, filename \\ "report_bookings.csv") do
    File.write!(filename, report, [:append])
  end
end
