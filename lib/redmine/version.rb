# frozen_string_literal: true

require 'zogo/scm/adapters/subversion_adapter'

module ZOGO
  # @private
  module VERSION
    MAJOR = 4
    MINOR = 2
    TINY  = 4

    # Branch values:
    # * official release: nil
    # * stable branch:    stable
    # * trunk:            devel
    BRANCH = 'devel'

    # Retrieves the revision from the working copy
    def self.revision
      if File.directory?(File.join(Rails.root, '.svn'))
        begin
          path = ZOGO::Scm::Adapters::AbstractAdapter.shell_quote(Rails.root.to_s)
          if `#{ZOGO::Scm::Adapters::SubversionAdapter.client_command} info --xml #{path}` =~ /commit\s+revision="(\d+)"/
            return $1.to_i
          end
        rescue
          # Could not find the current revision
        end
      end
      nil
    end

    REVISION = self.revision
    ARRAY    = [MAJOR, MINOR, TINY, BRANCH, REVISION].compact
    STRING   = ARRAY.join('.')

    def self.to_a; ARRAY  end
    def self.to_s; STRING end
  end
end
