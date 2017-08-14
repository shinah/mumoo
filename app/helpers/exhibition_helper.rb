module ExhibitionHelper
  def render_with_hashtags(hashtag)
    hashtag.gsub(/#[ㄱ-ㅎ가-힣0-9a-zA-Z]+/){|word| link_to word, "/exhibition/hashtag/#{word.delete('#')}"}.html_safe
  end
end
