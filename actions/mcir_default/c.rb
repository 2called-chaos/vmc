class Mcir::Action::C < Mcir::Action
  @name = "c"
  @desc = "open pry console in instance context"

  def call instance, args
    instance.pry
  end
end
