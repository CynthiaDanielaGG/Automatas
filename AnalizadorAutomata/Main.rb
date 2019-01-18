require 'fox16'

include Fox

class LabelExample < FXMainWindow
  def initialize(app)
    super(app, "Labels", :width => 300, :height => 100)

    question_icon =
        FXPNGIcon.new(app, File.open("open2.png", "rb").read)
    question_label =
        FXLabel.new(self, "Is it safe?", :icon => question_icon)


    question_label.iconPosition = ICON_BEFORE_TEXT

    question_label.layoutHints = LAYOUT_CENTER_X|LAYOUT_CENTER_Y
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    LabelExample.new(app)
    app.create
    app.run
  end
end