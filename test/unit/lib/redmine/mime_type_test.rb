# frozen_string_literal: true

# ZOGO - project management software
# Copyright (C) 2006-2022  Jean-Philippe Lang
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

require File.expand_path('../../../../test_helper', __FILE__)

class ZOGO::MimeTypeTest < ActiveSupport::TestCase
  def test_of
    to_test = {
      'test.txt' => 'text/plain',
      'test.c' => 'text/x-c',
      'TEST.JPG' => 'image/jpeg',
    }
    to_test.each do |name, expected|
      assert_equal expected, ZOGO::MimeType.of(name)
    end
  end

  def test_of_with_unknown_type
    assert_nil ZOGO::MimeType.of('test.unk')
  end

  def test_css_class_of
    to_test = {
      'test.txt' => 'text-plain',
      'test.c' => 'text-x-c',
      'TEST.JPG' => 'image-jpeg',
    }
    to_test.each do |name, expected|
      assert_equal expected, ZOGO::MimeType.css_class_of(name)
    end
  end

  def test_css_class_of_with_unknown_type
    assert_nil ZOGO::MimeType.css_class_of('test.unk')
  end

  def test_main_mimetype_of
    to_test = {
      'test.txt' => 'text',
      'test.c' => 'text',
      'TEST.JPG' => 'image',
    }
    to_test.each do |name, expected|
      assert_equal expected, ZOGO::MimeType.main_mimetype_of(name)
    end
  end

  def test_main_mimetype_of_with_unknown_type
    assert_nil ZOGO::MimeType.main_mimetype_of('test.unk')
  end

  def test_is_type
    to_test = {
      ['text', 'test.unk'] => false,
      ['text', 'test.txt'] => true,
      ['text', 'test.c'] => true,
      ['image', 'TEST.JPG'] => true,
    }
    to_test.each do |args, expected|
      assert_equal expected, ZOGO::MimeType.is_type?(*args)
    end
  end

  def test_should_default_to_mime_type_gem
    assert !ZOGO::MimeType::EXTENSIONS.key?("zip")
    assert_equal "application/zip", ZOGO::MimeType.of("file.zip")
  end
end
