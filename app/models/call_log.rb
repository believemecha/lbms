class CallLog < ApplicationRecord

    enum call_type:{
        outgoing: 0,
        incoming: 1,
        missed: 2
    }
end
