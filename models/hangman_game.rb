class HangmanGame < ActiveRecord::Base

  def self.create_word
words = <<-eos
  a convenient  hard  official  something
  able  convention  has often sometimes
  aboard  convict hat old son
  about copy  have  omit  song
  above cordially he  on  soon
  absence cost  head  once  sorry
  accept  could hear  one south
  accident  country heard only  speak
  according course  heart open  special
  account court height  opinion spell
  across  cover held  or  spend
  act crowd help  order spent
  action  cut her organization  spring
  add dark  here  organize  stamp
  addition  dash  herself other stand
  address date  high  ought start
  adopt daughter  him our state
  affair  day himself out statement
  afraid  dead  his outside station
  after deal  history over  stay
  afternoon dear  hold  own steamer
  again death home  page  still
  against debate  honor paid  stole
  age December  hope  pair  stone
  ago decide  horse paper stood
  agreement decision  hot part  stop
  air declare hour  particular  stopped
  alike deep  house party story
  all degree  how pass  street
  allege  delay however past  struck
  allow department  human pay study
  almost  desire  hurt  people  success
  alone destroy husband perfect such
  along develop I perhaps sudden
  already diamond ice period  suffer
  also  did if  personal  suggest
  although  died  illustrate  picture suit
  always  difference  immediate piece summer
  am  different importance  place summon
  among difficulty  important plan  Sunday
  amount  direct  impossible  plant supply
  an  direction imprison  play  support
  and director  improvement pleasant  suppose
  annual  disappoint  in  please  sure
  another discussion  include pleasure  surprise
  answer  distinguish income  point system
  any distribute  increase  police  table
  anything  district  indeed  political take
  anyway  divide  inform  poor  talk
  appear  do  information popular tax
  application doctor  injure  population  teach
  appoint does  inside  position  teacher
  appreciate  dollar  inspect possible  tell
  April instead post  ten
  are done  intend  pound tenth
  argument  door  interest  power term
  army  doubt into  practical terrible
  around  down  investigate prefer  testimony
  arrange dozen invitation  preliminary than
  arrangement dress is  prepare thank
  arrest  drill issue present that
  arrive  driven  it  president the
  article drown its press theater
  as  due itself  pretty  their
  ask during  jail  price them
  assist  duty  January primary themselves
  associate each  judge principal then
  association earliest  judgment  principle there
  assure  early July  print therefore
  at  east  June  prison  these
  athletic  easy  just  private they
  attempt eat justice probably  thing
  attend  education keep  proceed think
  attention effect  kill  progress  third
  August  effort  kind  promise this
  aunt  eight knew  prompt  those
  auto  either  know  proper  though
  automobile  elaborate known property  thought
  avenue  elect lady  prove three
  await election  lake  provide through
  away  else  land  provision throw
  awful emergency large public  Thursday
  baby  empire  last  publication thus
  back  employ  late  publish ticket
  bad enclose law purpose time
  ball  end lay push  tire
  band  engage  lead  put to
  be  engine  learn question  today
  bear  enjoy least quite together
  beautiful enough  leave race  told
  became  enter led railroad  tomorrow
  because entertain ledge rain  tonight
  become  entire  left  raise too
  bed entitle length  ran took
  been  entrance  less  rapid top
  before  escape  lesson  rate  total
  beg especially  let rather  toward
  began estate  letter  reach town
  begin estimate  liberty read  track
  beginning even  life  ready train
  begun evening light real  travel
  behind  event like  really  treasure
  believe ever  line  reason  tree
  belong  every list  receipt trip
  beside  everything  little  receive trouble
  best  evidence  live  recent  TRUE
  better  examination local recommend truly
  between except  long  recover trust
  big expect  look  red try
  bill  expense lose  refer Tuesday
  black experience  loss  reference turn
  block express lost  refuse  two
  blow  extra lot regard  unable
  blue  extreme love  region  uncle
  board eye low relative  under
  boat  face  machine relief  understand
  body  fact  madam remain  unfortunate
  book  factory made  remember  unless
  born  fail  mail  repair  until
  both  fair  majority  reply up
  bought  fall  make  report  upon
  box family  man represent us
  boy famous  manner  request use
  bridge  far many  respectfully  usual
  bring farther March responsible vacation
  broke father  marriage  rest  various
  brother favor material  restrain  very
  brought feature matter  result  vessel
  build February  may retire  victim
  built feel  May return  view
  burn  feet  maybe ride  visit
  business  fell  mayor right visitor
  busy  felt  me  ring  vote
  but few mean  river volume
  buy field meant road  wait
  by  fifth measure room  walk
  call  fight meet  round want
  came  figure  member  royal war
  camp  file  men rule  warm
  can fill  mention run was
  cannot  final mere  running watch
  capture finally might said  water
  car find  mile  sail  way
  card  fine  mind  salary  we
  care  finish  mine  same  wear
  career  fire  minute  Saturday  weather
  carried firm  Miss  saw Wednesday
  carry first miss  say week
  case  five  Monday  says  weigh
  cast  fix money scene well
  catch flight  month school  went
  cause folks more  sea were
  celebration follow  morning search  west
  cent  foot  most  second  what
  center  for mother  secretary when
  century foreign motion  section where
  certain forenoon  mountain  subject whether
  chain forget  move  secure  which
  change  form see while
  character fortune  seem  who
  charge  forty much  seen  whole
  check forward must  select  whom
  chief found my  senate  whose
  child four  name  send  why
  children  fourth  national  sent  wife
  Christmas free  navy  separate  will
  church  Friday  near  September wind
  circular  friend  nearly  serious winter
  circumstance  from  necessary serve wire
  cities  front need  service wish
  citizen full  neighbor  session with
  city  further neither set within
  claim game  never seven without
  class gave  new several witness
  clean general news  shall women
  clear gentleman newspaper she wonder
  clerk get next  shed  wonderful
  close getting nice  ship  word
  clothing  girl  night short work
  club  give  nine  should  world
  cold  glad  no  show  worth
  collect glass none  shut  would
  colonies  go  noon  sick  wreck
  combination God north side  write
  come  goes  not sight written
  comfort gold  nothing since wrote
  coming  gone  November  sincerely yard
  command good  now sir year
  committee got number  sister  yes
  common  government sit yesterday
  company grand object  six yet
  complaint grant objection size  you
  complete  great oblige  slide young
  concern ground  obtain  slower  your
  condition guess occupy  small
  conference  guest October so
  connection  had of  soap
  consider  half  off soft
  consideration hand  offer sold
  contain happen  office  some
  contract  happy
eos
words.split(" ").sample

  end

end

