module Selbot2
  class WhoBrokeIt
    include Cinch::Plugin

    HELPS << [":whobrokeit", "Announces who broke it"]

    prefix Selbot2::PREFIX
    match /whobrokeit/

    def execute(m)
      m.reply ["lukeis", "hugs", "jcarr", "dan"][rand(4)]
    end
  end # CI
end # Selbot2
