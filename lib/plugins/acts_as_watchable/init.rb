# frozen_string_literal: true

# Include hook code here
require File.dirname(__FILE__) + '/lib/acts_as_watchable'
ActiveRecord::Base.send(:include, ZOGO::Acts::Watchable)
