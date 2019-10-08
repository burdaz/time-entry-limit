require_dependency 'time_entry'

module TimeEntryPatch
  def self.included(base)
    base.class_eval do
      def validate_time_entry
        managers = Setting.plugin_time_entry_limit['managers'].split(/\W+/)
        unless managers.include?(User.current.login)
          errors.add :hours, :invalid if hours && (hours < Setting.plugin_time_entry_limit['min_hours'].to_i || hours >= Setting.plugin_time_entry_limit['max_hours'].to_i)
          errors.add :spent_on, :invalid if (spent_on - Date.today).to_i.abs > Setting.plugin_time_entry_limit['allowed_days'].to_i
        end
        errors.add :project_id, :invalid if project.nil?
        errors.add :issue_id, :invalid if (issue_id && !issue) || (issue && project!=issue.project) || @invalid_issue_id
        errors.add :activity_id, :inclusion if activity_id_changed? && project && !project.activities.include?(activity)
      end
    end
  end
end
