require "time"
require "yaml"
require "rabbit/task/slide"

config = YAML.load(File.read("config.yaml"))

slide_id = config["id"]
tags = config["tags"]
base_name = config["base_name"]
pdf_base_path = "#{base_name}.pdf"

version = nil
presentation_date = config["presentation_date"]
parsed_presentation_date = nil
if presentation_date
  begin
    parsed_presentation_date = Time.parse(presentation_date)
  rescue ArgumentError
  end
  if parsed_presentation_date
    version = parsed_presentation_date.strftime("%Y.%m.%d")
  end
end
version ||= "1.0.0"

name = config["name"]
email = config["email"]
rubygems_user = config["rubygems_user"]
slideshare_user = config["slideshare_user"]
speaker_deck_user = config["speaker_deck_user"]

readme = File.read(Dir.glob("README*")[0])

readme_blocks = readme.split(/(?:\r?\n){2,}/)
summary = (readme_blocks[0] || "TODO").gsub(/\A(?:[=*!]+|h\d\.) */, "")
description = readme_blocks[1] || "TODO"

specification = Gem::Specification.new do |spec|
  prefix = "rabbit-slide"
  spec.name = "#{prefix}-#{rubygems_user}-#{slide_id}"
  spec.version = version
  spec.homepage = "http://slide.rabbit-shockers.org/#{rubygems_user}/#{slide_id}/"
  spec.authors = [name]
  spec.email = [email]
  spec.summary = summary
  spec.description = description
  spec.licenses = [] # ["CC BY-SA 3.0"]

  spec.files = [".rabbit", "config.yaml", "Rakefile"]
  spec.files += Dir.glob("{COPYING,GPL,README*}")
  spec.files += Dir.glob("rabbit/**/*.*")
  spec.files += Dir.glob("**/*.{svg,png,jpg,jpeg,gif,eps,pdf}")
  spec.files += Dir.glob("*.{rd,rab,hiki,md,pdf}")
  spec.files -= Dir.glob("{pkg,pdf}/**/*.*")

  spec.add_runtime_dependency("rabbit")
end

Rabbit::Task::Slide.new(specification) do |task|
  task.rubygems_user = rubygems_user
  task.slideshare_user = slideshare_user
  task.speaker_deck_user = speaker_deck_user
  task.pdf_base_path = pdf_base_path
  task.tags = tags
  task.presentation_date = parsed_presentation_date
end
