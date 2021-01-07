# User seeding
user_list = {
    'Kyle' => {
      username: 'save',
      password: 'liontiger'
    },
    'Taylor' => {
      username: 'lightbulb',
      password: 'lightswitch'
    },
    'Kaycee' => {
      username: 'bucsfan',
      password: 'bruins19'
    },
    'Julian' => {
      username: 'thecreator',
      password: 'icreatedthis'
    },
    'Brandon' => {
      username: 'thesauceyman',
      password: 'ilovejulian'
    }
}
# '_' is customary for argument that won't be used
user_list.each do |_, u_hash|
    User.create(username: u_hash[:username], password: u_hash[:password])
end
  
# Assignment Seeding
def rand_by_five(low, high)
    loop do
        r = rand(low..high)
        return r if (r % 5).zero?
    end
end
  
a_types = {
'homework' => { low: 10, high: 20 },
'project' => { low: 50, high: 120 },
'test' => { low: 75, high: 150 }
}
  
30.times do
    s = a_types.to_a.sample # s = [type, score_possible_range]
    if s[0] == 'homework' 
        score_possible = rand(s[1][:low]..s[1][:high])
    else
        score_possible = rand_by_five(s[1][:low], s[1][:high])
    end 

    score_earned = rand((score_possible / 2).round(0)..score_possible)
    Assignment.create(category: s[0], score_earned: score_earned, score_possible: score_possible, user_id: rand(1..5))
end