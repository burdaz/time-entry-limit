require 'redmine'

TimeEntry.send(:include, TimeEntryPatch)

Redmine::Plugin.register :time_entry_limit do
  name 'Time Entry Limit plugin'
  author 'Zdeněk Burda'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/burdaz/time-entry-limit.git'
  author_url 'http://github.com/burdaz/'

  settings :default => {
    'min_hours' => 0,
		'max_hours' => 24,
		'allowed_days' => 2,
		'managers' => 'admin'},
    :partial => 'settings/time_entry_limit_settings'
end
