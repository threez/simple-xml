require "rexml/document"
require "rexml/xpath"
require File.join(File.dirname(__FILE__), "simple_xml", "simplifyer")

class REXML::Element
  include SimpleXML::Simplifyer
end
