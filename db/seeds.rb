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

a_list = {
  'homework' => { low: 10, high: 20 },
  'project' => { low: 50, high: 120 },
  'test' => { low: 75, high: 150 }
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
  subject_list.each do |sbj|
    user.subjects << Subject.create(title: sbj)
  end
end

# Assignment Seeding
def rand_by_five(low, high)
  loop do
    r = rand(low..high)
    return r if (r % 5).zero?
  end
end

(Subject.count * 7).times do
  sbj = a_list.to_a.sample # s = [type, score_range_obj]
  if sbj[0] == 'homework' 
    s_possible = rand(sbj[1][:low]..sbj[1][:high])
  else
    s_possible = rand_by_five(sbj[1][:low], sbj[1][:high])
  end
  s_earned = rand((s_possible / 2).round(0)..s_possible)
  a_hash = {
    category: sbj[0],
    score_earned: s_earned,
    score_possible: s_possible,
    subject_id: rand(1..Subject.count),
    # rand returns date object, strftime (string format time)
    date: rand(1.year.ago..1.year.from_now).strftime('%Y-%m-%d')
  }

  Assignment.create(a_hash)
end
