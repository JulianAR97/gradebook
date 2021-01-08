# User / Subject seedings
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

subject_list = [
  'math',
  'science',
  'history',
  'english',
  'computer science'
]
# '_' is customary for argument that won't be used
user_list.each do |_, u_hash|
    user = User.create(username: u_hash[:username], password: u_hash[:password])
    subject_list.each do |s|
      user.subjects << Subject.create(title: s)
    end
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
(Subject.count * 7).times do
    s = a_types.to_a.sample # s = [type, score_possible_range]
    if s[0] == 'homework' 
        score_possible = rand(s[1][:low]..s[1][:high])
    else
        score_possible = rand_by_five(s[1][:low], s[1][:high])
    end

    score_earned = rand((score_possible / 2).round(0)..score_possible)
    assignment_hash = {
      category: s[0],
      score_earned: score_earned,
      score_possible: score_possible,
      subject_id: rand(1..Subject.count),
      # rand returns date object, strftime (string format time)
      date: rand(1.year.ago..1.year.from_now).strftime('%m/%d/%Y')
    }

    Assignment.create(assignment_hash)
end
