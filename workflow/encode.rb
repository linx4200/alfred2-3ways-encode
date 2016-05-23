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

  def base64_encode()
    Base64.encode64(@str)
  end

  def base64_decode()
    Base64.decode64(@str)
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

  fb.add_item(title: encode.md5, subtitle: 'md5 (32位小写)')
  fb.add_item(title: encode.md5.upcase!, subtitle: 'md5 (32位大写)')
  fb.add_item(title: encode.base64_encode, subtitle: 'base64 encode')
  fb.add_item(title: encode.base64_decode, subtitle: 'base64 decode')
  fb.add_item(title: encode.urlencode, subtitle: 'url encode')

  # TODO xml的arg如果是中文,alfred不支持
  fb.add_item(title: encode.urldecode, subtitle: "url decode", arg: toUnicode(encode.urldecode))

  puts fb.to_alfred()

end