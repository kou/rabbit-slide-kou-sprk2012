sprk2012_dark_color = "#293745"

add_image_path("sprk2012")

@slide_logo_image_uninstall = true
@title_slide_subtitle_font_size = @small_font_size

include_theme("clear-code")

background_image = "sprk2012-background-image.svg"
@slide_background_image = background_image
@title_slide_background_image = background_image
include_theme("slide-background-image")
include_theme("title-slide-background-image")

match(TitleSlide, "*") do |elements|
  prop_set("foreground", sprk2012_dark_color)
end

match(TitleSlide, Author) do |authors|
  name = "float-right-author"

  delete_pre_draw_proc_by_name(name)
  authors.each do |source|
    original_location = nil
    source.add_pre_draw_proc do |canvas, x, y, w, h, simulation|
      original_location = [x, y, w, h]
      [x, y, w, h]
    end
    source.add_post_draw_proc do |canvas, x, y, w, h, simulation|
      original_location
    end
  end
end

match(TitleSlide, Institution) do |institutions|
  institutions.align = :left
end

match(TitleSlide, ContentSource) do |sources|
  name = "float-left-content-source"

  sources.align = :left

  delete_pre_draw_proc_by_name(name)
  sources.each do |source|
    original_location = nil
    source.add_pre_draw_proc do |canvas, x, y, w, h, simulation|
      original_location = [x, y, w, h]
      [x, y, w, h]
    end
    source.add_post_draw_proc do |canvas, x, y, w, h, simulation|
      original_location
    end
  end
end

slide_footer_info_proc_name = "slide-footer-info"
match(TitleSlide) do
  delete_pre_draw_proc_by_name(slide_footer_info_proc_name)
end

match(Slide) do |slides|
  last_slide = slides.pop
  rest_slides = slides
  rest_slides.each do |slide|
    slide.delete_pre_draw_proc_by_name("slide-background-image")
  end

  last_slide.delete_pre_draw_proc_by_name(slide_footer_info_proc_name)
  last_slide.delete_post_draw_proc_by_name("image-slide-number")
  last_slide.delete_post_draw_proc_by_name("image-timer")
  last_slide.margin_with(:top    => screen_y(10),
                         :bottom => screen_y(10))

  last_slide.prop_set("foreground", sprk2012_dark_color)
end
