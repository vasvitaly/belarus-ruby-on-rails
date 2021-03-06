module Admin::UsersHelper
  def link_to_admin_title(user)
    user.is_admin ? t('admin.users.remove_admin') : t('admin.users.make_admin')
  end

  def link_to_banned_title(user)
    user.banned ? t('admin.users.unban') : t('admin.users.ban')
  end

  def accepted_status(user, meetup_id)
    participation = user.participants.find_by_meetup_id(meetup_id)
    participation.accepted if participation
  end
end
