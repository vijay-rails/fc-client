module ApplicationHelper

  def fahrenheit_to_celcius(temperature)
    (temperature - 32) * 5 / 9
  end
end
