#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require './bundle/bundler/setup'
require 'alfred'
require 'digest/md5'
require 'base64'
require 'uri'
require 'iconv'

class Encode
  def initialize(str)
    @str = str
  end

  def md5()
    Digest::MD5.hexdigest(@str)
  end

  def base64()
    Base64.encode64(@str)
  end

  def urlencode()
    URI.escape(@str)
  end

  def urldecode()
    URI.unescape(@str)
  end
end

def toUnicode (str)
  i = 0
  unicode = ''
  Iconv.iconv("UNICODEBIG//","UTF-8", str)[0].each_byte { |b|
    if i % 2 == 0
      unicode += "&\#x#{b.to_s(16)}"
    else
      unicode += "#{b.to_s(16)};"
    end
    i += 1
  }
  unicode
end

Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback

  str = ARGV[0]

  encode = Encode.new(str)

  fb.add_item(title: encode.md5, subtitle: 'md5')
  fb.add_item(title: encode.base64, subtitle: 'base64')
  fb.add_item(title: encode.urlencode, subtitle: 'url encode')

  # TODO arg是中文 alfred 不支持
  # fb.add_item(title: encode.urldecode, subtitle: "url decode", arg: toUnicode(encode.urldecode))

  puts fb.to_alfred()

end