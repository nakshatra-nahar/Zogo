# frozen_string_literal: true

require File.dirname(__FILE__) + '/lib/acts_as_event'
ActiveRecord::Base.send(:include, ZOGO::Acts::Event)
