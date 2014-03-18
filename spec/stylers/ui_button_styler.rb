class SyleSheetForUIViewStylerTests < RubyMotionQuery::Stylesheet

  def ui_button_kitchen_sink(st)
    st.text = 'foo'
    st.font = font.system(12)
    st.color = color.red
    st.image_normal = image.resource('logo')
    st.image_highlighted = image.resource('logo')
  end

end

describe 'stylers/ui_button' do
  before do
    @vc = UIViewController.alloc.init
    @vc.rmq.stylesheet = SyleSheetForUIViewStylerTests
    @view_klass = UIButton
  end

  behaves_like "styler"

  it 'should apply a style with every UIButtonStyler wrapper method' do
    view = @vc.rmq.append(@view_klass, :ui_button_kitchen_sink).get

    view.tap do |v|
      # TODO
      1.should == 1
    end

  end

  describe "bordered button extensions" do
    before { @view = @vc.rmq.append(@view_klass, :ui_button_kitchen_sink) }

    describe "border width" do
      before{ @view.style{|st| st.border_width = 2} }

      it 'should be able to add a border to a button' do
        @view.get.layer.borderWidth.should == 2
      end

      it "can get a border width for a button" do
        bw = nil
        @view.style{|st| bw = st.border_width}
        bw.should == 2
      end
    end

    describe "corner radius" do
      before{ @view.style{|st| st.corner_radius = 10} }

      it "sets the corner radius" { @view.get.layer.cornerRadius.should == 10 }
      it "gets the corner radius" do
        cr = nil
        @view.style{|st| cr = st.corner_radius}
        cr.should == 10
      end
    end

    describe "border colors" do
      before{ @view.style{|st| st.border_color = rmq.color.blue} }

      it "sets the correct number of color components" do
        CGColorGetNumberOfComponents(@view.get.layer.borderColor).should >= 4
      end

      it "sets the right colors" do
        color = nil
        @view.style{|st| color = st.border_color}
        components = CGColorGetComponents(color)

        # R=0, G=0, B=1 A=1

        components[0].to_i.should == 0
        components[1].to_i.should == 0
        components[2].to_i.should == 1
        components[3].to_i.should == 1
      end
    end
  end
<<<<<<< HEAD
=======

>>>>>>> 0fb018c2b447a7aa15dc2df184d258b7a5f2d73a
end
