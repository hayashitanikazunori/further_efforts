module UsersHelper
  def follow_view(type)
    type.includes(:avatar_attachment)
  end

  def ranking(rank)
    if rank == 1
      image_tag 'rank_top1', class: 'image_size_70'
    elsif rank == 2
      image_tag 'rank_top2', class: 'image_size_70'
    elsif rank == 3
      image_tag 'rank_top3', class: 'image_size_70'
    else
      rank
    end
  end

  def user_week_time(user)
    "#{user.week_learn_time / 60}時間#{user.week_learn_time % 60}分"
  end
end
