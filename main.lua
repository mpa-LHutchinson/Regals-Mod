

local mod = SMODS.current_mod
SMODS.Atlas{
    key = 'Jokers',
    path = 'Jokers.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Decks',
    path = 'Decks.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'collegejoker',
    loc_txt = { 
        name = 'College Joker',
        text = {
          '{X:mult,C:white}X#1#{} Mult if hand',
          'is played while',
          'in debt or at {C:money}$0{}'
        },
    },
    atlas = 'Jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0}, 
    config = { 
      extra = {
        Xmult = 4
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    calculate = function(self,card,context)
        if context.joker_main and G.GAME.dollars <= 0 then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = '4 Years!',
                colour = G.C.MULT
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'valentinesdaygift',
    loc_txt = {
        name = 'Valentines Day Gift',
        text = {
          'Each card held',
          'in hand with {C:hearts}Heart{}',
          'suit gives {C:mult}+#1#{} Mult'
        },
    },
    atlas = 'Jokers',
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 1, y = 0}, 
    config = { 
      extra = {
        mult = 6
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult}}
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.hand and context.individual and not context.end_of_round and context.other_card:is_suit("Hearts") then
            return {
                card = card,
                mult_mod = card.ability.extra.mult,
                message = '<3',
                colour = G.C.MULT
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'cottoncandy',
    loc_txt = {
        name = 'Cotton Candy',
        text = {
          'Sell this card to',
          'create {C:attention}#1#{} free',
          '{C:attention}Voucher Tag{}',
        },
    },
    atlas = 'Jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true, 
    blueprint_compat = true,
    eternal_compat = false, 
    perishable_compat = true, 
    pos = {x = 2, y = 0},
    config = { 
      extra = {
        new_tags = 1
      }
    },
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = {key = 'tag_voucher', set = 'Tag'}
        return {vars = {center.ability.extra.new_tags}}
    end,
    calculate = function(self,card,context)
        if context.selling_self then
            for i=1, card.ability.extra.new_tags do
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_voucher'))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end)
                }))
            end
            return {
                card = card,
                message = 'Sweet!',
                colour = G.C.MONEY
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'artisticjoker',
    loc_txt = {
        name = 'Artistic Joker',
        text = {
          '{C:mult}+#2#{} mult',
          'per hand size',
          '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)'
        },
    },
    atlas = 'Jokers',
    rarity = 1, 
    cost = 5,
    unlocked = true, 
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 3, y = 0},
    config = { 
      extra = {
        mult = 16, 
        mult_mod = 2
      }
    },
    loc_vars = function(self,info_queue,center)
        if G.hand and G.hand.config and G.hand.config.card_limit then
            center.ability.extra.mult = G.hand.config.card_limit * center.ability.extra.mult_mod  
        end
        return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod}}
    end,
    calculate = function(self,card,context)
        if G.hand and G.hand.config and G.hand.config.card_limit then
            card.ability.extra.mult = G.hand.config.card_limit * card.ability.extra.mult_mod  
        end
        if context.joker_main then
            return {
                card = card,
                mult_mod = card.ability.extra.mult,
                message = 'Brush Brush!',
                colour = G.C.MULT
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'spinningtop',
    loc_txt = {
        name = 'Spinning Top',
        text = {
          'Creates a {C:attention}The Wheel{}',
          '{C:attention}of Fortune{} {C:tarot}Tarot{} card', 
          'at the end of the {C:attention}Shop{}',
          '{C:inactive}(Must have room)'
        },
        
    },
    atlas = 'Jokers',
    rarity = 1, 
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 4, y = 0}, 
    config = { 
      extra = {
      }
    },
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = G.P_CENTERS.c_wheel_of_fortune
        return {vars = {}}
    end,
    calculate = function(self,card,context)
        if context.ending_shop then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', 'wheel')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                                return true
                            end}))   
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = 'Spin!', colour = G.C.PURPLE})                       
                        return true
                    end)}))
            end
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'mushroom',
    loc_txt = {
        name = 'Mushroom',
        text = {
          'Upgrades the first',
          'played {C:attention}poker hand{}',
          'for the next',
          '{C:attention}#1#{} rounds'
        },
        
    },
    atlas = 'Jokers',
    rarity = 1, 
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    pos = {x = 5, y = 0}, 
    config = { 
      extra = {
        remaining = 3,
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.remaining}}
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and G.GAME.current_round.hands_played == 0 then
            level_up_hand(context.blueprint_card or card, context.scoring_name, nil, 1)

            return {
                card = card,
                message = 'Level Up!',
                colour = G.C.PURPLE
            }
            
        end
        if context.after and G.GAME.current_round.hands_played == 0 and not context.blueprint then
            card.ability.extra.remaining = card.ability.extra.remaining - 1
            if card.ability.extra.remaining <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                G.jokers:remove_card(self)
                                card:remove()
                                card = nil
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = 'Eaten!',
                    colour = G.C.PURPLE
                }
            else
                return {
                    message = '-1',
                    colour = G.C.PURPLE
                }
            end
            
        end
    end,

    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'tubbyjoker', 
    loc_txt = { 
        name = 'Tubby Joker',
        text = {
          'This Joker gains {C:mult}+#2#{} Mult',
          'if played hand contains',
          '{C:attention}5 scoring cards',
          '{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)'
        },
        
    },
    atlas = 'Jokers', 
    rarity = 1, 
    cost = 5, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 6, y = 0}, 
    config = { 
      extra = {
        mult = 0,
        mult_mod = 2
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod}} 
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and #context.scoring_hand == 5 and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return {
                card = card,
                message = 'Weight gained!',
                colour = G.C.MULT
            }
        elseif context.joker_main then
            return {
                card = card,
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult,
                colour = G.C.MULT
            }
        
        end
    end,

    in_pool = function(self,wawa,wawa2)
        
        return true
    end,
}
SMODS.Joker{
    key = '3djoker', 
    loc_txt = { 
        name = '3D Joker',
        text = {
          "{C:attention}Bonus Cards{} also",
          "score {C:mult}+#2# mult{},",
          "{C:attention}Mult Cards{} also",
          "score {C:chips}+#1# chips{}"
        },
        
    },
    atlas = 'Jokers', 
    rarity = 2, 
    cost = 5, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 7, y = 0}, 
    config = { 
      extra = {
        chips_mod = 75,
        mult_mod = 10
      }
    },
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = G.P_CENTERS.m_bonus
        info_queue[#info_queue+1] = G.P_CENTERS.m_mult
        return {vars = {center.ability.extra.chips_mod, center.ability.extra.mult_mod}} 
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            if context.other_card.config.center.key == 'm_bonus' then
                return {mult_mod = card.ability.extra.mult_mod, message = '3D', colour = G.C.MULT}
            end
            if context.other_card.config.center.key == 'm_mult' then
                return {chip_mod = card.ability.extra.chips_mod, message = '3D', colour = G.C.CHIPS}
            end
        end
    end,

    in_pool = function(self,wawa,wawa2)
        for _, playing_card in pairs(G.playing_cards) do
            if SMODS.has_enhancement(playing_card, 'm_bonus') or SMODS.has_enhancement(playing_card, 'm_mult')  then
                return true
            end
        end
        return false
    end,
}
SMODS.Joker{
    key = 'oljimwilly', 
    loc_txt = { 
        name = 'Ol\' Jim Willy',
        text = {
          "Converts the next",
          "{C:attention}#1#{} scored cards",
          "into {C:spades}Spades{}"
        },
        
    },
    atlas = 'Jokers', 
    rarity = 1, 
    cost = 6, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = false, 
    eternal_compat = false, 
    perishable_compat = true, 
    pos = {x = 8, y = 0}, 
    config = { 
      extra = {
        remaining = 12
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.remaining}} 
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and not context.blueprint then
            for k, v in ipairs(context.scoring_hand) do
                if card.ability.extra.remaining > 0 then
                    card.ability.extra.remaining = card.ability.extra.remaining - 1 
                    v:change_suit('Spades');

                    if G.GAME.blind.boss then
                        v.ability.played_this_ante = false;
                    end

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    }))
                    G.GAME.blind:debuff_card(v)
                end
            end
            return {
                message = 'Ink!', 
                colour = G.C.SUITS['Spades']
            }
        end

        if context.after and not context.blueprint then
            if card.ability.extra.remaining <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                G.jokers:remove_card(self)
                                card:remove()
                                card = nil
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = 'That\'s all folks!',
                    colour = G.C.SUITS['Spades']
                }
            end
        end
    end,

    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'phoenix', 
    loc_txt = { 
        name = 'Phoenix',
        text = {
          'When {C:attention}Blind{} is selected, create',
          'a {C:tarot}Tarot{} or {C:planet}Planet{} card.', 
          '{C:green}#1# in #2#{} chance to also',
          'create a {C:spectral}Spectral{} card',
          '{C:inactive}(Must have room)'
        },
        
    },
    atlas = 'Jokers', 
    rarity = 3, 
    cost = 8, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 9, y = 0}, 
    config = { 
      extra = {
        odds = 3
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {G.GAME.probabilities.normal, center.ability.extra.odds}} 
    end,
    calculate = function(self,card,context)
        if context.setting_blind then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                local card = create_card('Tarot_Planet',G.consumeables, nil, nil, nil, nil, nil, 'phoenix')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                                return true
                            end}))   
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = 'Flames!', colour = G.C.RED})                       
                        return true
                    end)}))
            end
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and pseudorandom('phoe') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'phoenix')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                                return true
                            end}))   
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = 'Blue flames!', colour = G.C.BLUE})                       
                        return true
                    end)}))
            end
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'welfare', 
    loc_txt = { 
        name = 'Welfare',
        text = {
          'If money is under',
          '{C:money}$#1#{} when round',
          'ends, earn {C:money}$#2#{}'
        },
        
    },
    atlas = 'Jokers', 
    rarity = 1, 
    cost = 5, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = false, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 0, y = 1}, 
    config = { 
      extra = {
        money_cap = 15,
        money = 6
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.money_cap, center.ability.extra.money}} 
    end,
    
    calc_dollar_bonus = function(self,card)
        if G.GAME.dollars < card.ability.extra.money_cap then
            return card.ability.extra.money
        end
    end,

    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'pocketaces', 
    loc_txt = { 
        name = 'Pocket Aces',
        text = {
          'When entering a {C:attention}Boss{}',
          '{C:attention}Blind{}, add {C:attention}2 Enhanced{}',
          '{C:attention}Aces{} to your hand ',
        },
        
    },
    atlas = 'Jokers', 
    rarity = 3, 
    cost = 7, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 1, y = 1}, 
    config = { 
      extra = {
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {}}
    end,

    calculate = function(self, card, context)
        if context.first_hand_drawn and G.GAME.blind.boss then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local cen_pool = {}
                    for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if v.key ~= 'm_stone' then
                            cen_pool[#cen_pool+1] = v
                        end
                    end
                    for i = 1, 2 do
                        local _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('pocket'))
                        local new_card = create_playing_card({front = G.P_CARDS[_suit..'_A'], center = pseudorandom_element(cen_pool, pseudoseed('pocket'))}, G.hand, nil, i ~= 1, {G.C.SECONDARY_SET.Enhanced})
                        G.GAME.blind:debuff_card(new_card)
                        playing_card_joker_effects({true})
                    end
                    G.hand:sort()
                    return true
                end
            }))
            

            return {
                message = 'Aces!',
                colour = G.C.MULT
            }
        end
    end,

    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'medusa', 
    loc_txt = { 
        name = 'Medusa',
        text = {
          'Converts all scored cards',
          'from {C:attention}first hand{} each',
          'round into {C:attention}Stone Cards{}'
        },
        
    },
    atlas = 'Jokers', 
    rarity = 2, 
    cost = 7, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = false, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 2, y = 1}, 
    config = { 
      extra = {
      }
    },
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        return {vars = {}} 
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and G.GAME.current_round.hands_played == 0 and not context.blueprint then
            for k, v in ipairs(context.scoring_hand) do
                v:set_ability(G.P_CENTERS.m_stone, nil, true)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:juice_up()
                        return true
                    end
                }))
                G.GAME.blind:debuff_card(v) 
            end
            return {message = 'Gaze!', colour = G.C.PURPLE}
        end
    end,

    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'workoutroutine', 
    loc_txt = { 
        name = 'Workout Routine',
        text = {
          'Cycles between scoring',
          '1. {C:chips}+#1#{} Chips',
          '2. {C:mult}+#2#{} Mult',
          '3. {X:mult,C:white}X#3#{} Mult',
          'when round ends',
          '{C:inactive}(Currently {B:2,V:1}#5##6#{}{C:inactive} #7#){}'
        },
        
    },
    atlas = 'Jokers', 
    rarity = 2, 
    cost = 6, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 3, y = 1}, 
    config = { 
      extra = {
        chips = 75,
        mult = 15,
        Xmult = 2,
        cycle = 1,
        current_text = "Chips",
        current_operator = "+",
        current_number = 75,
        current_colour = G.C.CHIPS,
        current_background = G.C.WHITE
      }
    },
    loc_vars = function(self, info_queue, center)
        local chips = center.ability.extra.chips
        local mult = center.ability.extra.mult
        local xmult = center.ability.extra.Xmult

        local cycle = center.ability.extra.cycle

        return {vars = {chips, mult, xmult, cycle, center.ability.extra.current_operator, center.ability.extra.current_number, center.ability.extra.current_text,  colours = {center.ability.extra.current_colour, center.ability.extra.current_background}}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            if card.ability.extra.cycle == 1 then
                return {
                    card = card,
                    chip_mod = card.ability.extra.chips,
                    message = '+' .. card.ability.extra.chips,
                    colour = G.C.CHIPS
                }
            elseif card.ability.extra.cycle == 2 then
                return {
                    card = card,
                    mult_mod = card.ability.extra.mult,
                    message = '+' .. card.ability.extra.mult,
                    colour = G.C.MULT
                }
            elseif card.ability.extra.cycle == 3 then
                return {
                    card = card,
                    Xmult_mod = card.ability.extra.Xmult,
                    message = 'X' .. card.ability.extra.Xmult,
                    colour = G.C.MULT
                }
            end
        end
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            if card.ability.extra.cycle == 1 then
                card.ability.extra.cycle = 2
                card.ability.extra.current_text = "Mult"
                card.ability.extra.current_colour = G.C.MULT
                card.ability.extra.current_operator = "+"
                card.ability.extra.current_number = card.ability.extra.mult
                card.ability.extra.current_background = G.C.WHITE

            elseif card.ability.extra.cycle == 2 then
                card.ability.extra.cycle = 3
                card.ability.extra.current_text = "Mult"
                card.ability.extra.current_colour = G.C.WHITE
                card.ability.extra.current_operator = "X"
                card.ability.extra.current_number = card.ability.extra.Xmult
                card.ability.extra.current_background = G.C.MULT

            elseif card.ability.extra.cycle == 3 then
                card.ability.extra.cycle = 1
                card.ability.extra.current_text = "Chips"
                card.ability.extra.current_colour = G.C.CHIPS
                card.ability.extra.current_operator = "+"
                card.ability.extra.current_number = card.ability.extra.chips
                card.ability.extra.current_background = G.C.WHITE

            end
            return {
                message = 'Next Rep!',
                colour = G.C.MONEY
            }
        end
    end,

    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'middlefinger', 
    loc_txt = { 
        name = 'Middle Finger',
        text = {
          '{X:mult,C:white}X#1#{} Mult during',
          '{C:attention}Boss Blinds{}'
        },
        
    },
    atlas = 'Jokers', 
    rarity = 3, 
    cost = 7, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 4, y = 1}, 
    config = { 
      extra = {
        Xmult = 3 
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} 
    end,
    calculate = function(self,card,context)
        if context.joker_main and G.GAME.blind.boss then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'F**k You!',
                colour = G.C.MULT
            }
        end
    end,

    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'vengefulspirit', 
    loc_txt = { 
        name = 'Vengeful Spirit',
        text = {
          '{X:mult,C:white}X#2#{} Mult per {C:spectral}Spectral{}',
          'card used this run',
          '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive})'
        },
        
    },
    atlas = 'Jokers', 
    rarity = 2, 
    cost = 6, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 5, y = 1}, 
    config = { 
      extra = {
        Xmult = 1,
        Xmult_mod = 0.25
      }
    },
    loc_vars = function(self,info_queue,center)
        if G.GAME.consumeable_usage_total then
            center.ability.extra.Xmult = 1 + (G.GAME.consumeable_usage_total.spectral * center.ability.extra.Xmult_mod) 
        end
        return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_mod}} 
    end,
    calculate = function(self,card,context)
        if G.GAME.consumeable_usage_total and not context.blueprint then
            card.ability.extra.Xmult = 1 + (G.GAME.consumeable_usage_total.spectral * card.ability.extra.Xmult_mod) 
        end

        if context.using_consumeable and not context.blueprint then
            if  context.consumeable.ability.set == "Spectral" then
                return {
                    message = 'Haunting!',
                    colour = G.C.SECONDARY_SET.Spectral
                }
            end
        end
        
        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'scratchticket', 
    loc_txt = { 
        name = 'Scratch Ticket',
        text = {
          'Sell this card for',
          'a {C:green}#1# in #2#{} chance',
          'to win {C:money}$#3#{}',
        },
        
    },
    atlas = 'Jokers', 
    rarity = 1, 
    cost = 2, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = false, 
    perishable_compat = true, 
    pixel_size = { w = 0.81 * 71, h = 0.78 * 95 },
    pos = {x = 6, y = 1}, 
    config = { 
      extra = {
        odds = 15,
        money = 40
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {G.GAME.probabilities.normal, center.ability.extra.odds, center.ability.extra.money}} 
    end,
    calculate = function(self,card,context)
        if context.selling_self then 
            if pseudorandom('lott') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    card = card,
                    dollars = card.ability.extra.money,
                    message = 'Winner!',
                    colour = G.C.MONEY
                }
            else
                return {
                    card = card,
                    message = 'Nope!',
                    colour = G.C.MONEY
                }
            end
        end
    end,
    in_pool = function(self,wawa,wawa2)
        
        return true
    end,
}
SMODS.Joker{
    key = 'eventhorizon', 
    loc_txt = { 
        name = 'Event Horizon',
        text = {
          'Creates a {C:attention}Black Hole{} {C:spectral}Spectral{}',
          'card at the end of the round if',
          'at least {C:attention}#2#{} unique hand types',
          'were played this round',
          '{C:inactive}(Must have room)',
          '{C:inactive}(Currently {C:attention}#1#{C:inactive}/#2#)'
        },
        
    },
    atlas = 'Jokers', 
    rarity = 3, 
    cost = 8, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = false, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 7, y = 1}, 
    config = { 
      extra = {
        unique_hands = 0,
        required = 3
      }
    },
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = G.P_CENTERS.c_black_hole
        return {vars = {center.ability.extra.unique_hands, center.ability.extra.required}} 
    end,
    calculate = function(self,card,context)

        if context.cardarea == G.jokers and G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round == 1 and not context.blueprint and context.before then 
            if card.ability.extra.unique_hands < card.ability.extra.required then
                card.ability.extra.unique_hands = card.ability.extra.unique_hands + 1
                if card.ability.extra.unique_hands < card.ability.extra.required then
                    return{
                        message = 'Drifting closer...',
                        card = card,
                        colour = G.C.BLACK
                    }
                elseif card.ability.extra.unique_hands == card.ability.extra.required then
                    local eval = function(card) return (card.ability.extra.unique_hands ~= 0) end
                    juice_card_until(card, eval, true)
                    return{
                        message = 'Active!',
                        card = card,
                        colour = G.C.BLACK
                    }
                end
            end             
        end
        
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            if card.ability.extra.unique_hands >= card.ability.extra.required then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            G.E_MANAGER:add_event(Event({
                                func = function() 
                                    local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, 'c_black_hole', 'eventhorizon')
                                    card:add_to_deck()
                                    G.consumeables:emplace(card)
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end}))   
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = 'Black Hole!', colour = G.C.BLACK})                       
                            return true
                        end)}))
                end
            end
            card.ability.extra.unique_hands = 0
            return{
                message = 'Reset',
                card = card,
                colour = G.C.BLACK
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'euchre', 
    loc_txt = { 
        name = 'Euchre',
        text = {
          'Each {C:attention}Jack{} held in',
          'hand at the end of',
          'the round earns {C:money}$#1#{}'
        },
        
    },
    atlas = 'Jokers', 
    rarity = 1, 
    cost = 5, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 8, y = 1}, 
    config = { 
      extra = {
        money = 3 
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.money}} 
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.hand and context.individual and context.end_of_round and context.other_card:get_id() == 11 then
            return {
                card = card,
                extra = {focus = card, message = 'Euchre!', colour = G.C.MONEY},
                dollars = card.ability.extra.money
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        
        return true
    end,
}
SMODS.Joker{
    key = 'jackpot', 
    loc_txt = { 
        name = 'Jackpot',
        text = {
          'If played hand contains {C:attention}3',
          'scoring {C:attention}7s{}, score {C:mult}+#2# mult{}',
          'and earn {C:money}$#1#{} at',
          'the end of the round'
        },
        
    },
    atlas = 'Jokers', 
    rarity = 2, 
    cost = 6, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 9, y = 1}, 
    config = { 
      extra = {
        money = 15,
        mult = 20,
        jackpot = false
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.money, center.ability.extra.mult, center.ability.extra.jackpot}} 
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.jokers and context.joker_main then
            local sevens = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 7 then
                    sevens = sevens + 1
                end
            end

            if sevens >= 3 then
                card.ability.extra.jackpot = true
                local eval = function(card) return (card.ability.extra.jackpot == true) end
                juice_card_until(card, eval, true)
                return {
                    card = card,
                    mult_mod = card.ability.extra.mult,
                    message = 'Jackpot!',
                    colour = G.C.MONEY,
                }
            end

        end
    end,
    calc_dollar_bonus = function(self,card)
        if card.ability.extra.jackpot then
            card.ability.extra.jackpot = false
            return card.ability.extra.money
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'dragonegg', 
    loc_txt = { 
        name = 'Dragon Egg',
        text = {
          'Will transform into a',
          'random {C:red}Rare{C:attention} Joker{}',
          'after {C:attention}#2#{} rounds,',
          '{C:attention}Editions{} are kept',
          '{C:inactive}(Currently {C:attention}#1#{C:inactive}/#2#)'
        },
        
    },
    atlas = 'Jokers', 
    rarity = 2, 
    cost = 5, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = false, 
    eternal_compat = false, 
    perishable_compat = true, 
    pos = {x = 0, y = 2}, 
    config = { 
      extra = {
        rounds = 0,
        required = 3
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.rounds, center.ability.extra.required}} 
    end,
    calculate = function(self,card,context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            local current_edition = card.edition
            if card.ability.extra.rounds < card.ability.extra.required then
                card.ability.extra.rounds = card.ability.extra.rounds + 1
                    if card.ability.extra.rounds >= card.ability.extra.required then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                play_sound('tarot1')
                                card:juice_up(0.3, 0.4)
                                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                    func = function()
                                        G.jokers:remove_card(self)
                                        card:remove()
                                        card = nil
                                        return true
                                    end
                                }))
                                return true
                            end
                        }))
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                    local card = create_card('Joker', G.jokers, nil, 2, nil, nil, nil, 'dra')
                                    card:add_to_deck()
                                    G.jokers:emplace(card)
                                    card:start_materialize()
                                    card:set_edition(current_edition, true)
                                return true
                            end}))  
                        return {
                            card = card,
                            message = 'Hatched!',
                            colour = G.C.MONEY,
                        }
                    end 
                return {
                    card = card,
                    message = card.ability.extra.rounds .. '/' .. card.ability.extra.required,
                    colour = G.C.MONEY,
                }
            end
            
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'dynamite', 
    loc_txt = { 
        name = 'Dynamite',
        text = {
          'At the end of the round,',
          '{C:attention}destroy{} a random card held',
          'in hand and gain {C:mult}+#2#{} Mult',
          '{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)'
        },
        
    },
    atlas = 'Jokers', 
    rarity = 2, 
    cost = 6, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 1, y = 2}, 
    config = { 
      extra = {
        mult = 0,
        mult_mod = 3
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod}} 
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
            local destroyed_cards = {}
            destroyed_cards[#destroyed_cards+1] = pseudorandom_element(G.hand.cards, pseudoseed('random_destroy'))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.6,
                func = function()
                    play_sound('tarot1')
                    for i = #destroyed_cards, 1, -1 do
                        local card = destroyed_cards[i]
                        if card and card.ability then
                            if card.ability.name == 'Glass Card' then 
                                card:shatter()
                            else
                                card:start_dissolve()
                            end
                            if card.config.center.key == "m_glass" then
                                SMODS.calculate_context({cards_destroyed = true, glass_shattered = { card }})
                            else
                                SMODS.calculate_context({remove_playing_cards = true, removed = { card }})
                            end
                        end
                    end
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.7,
                func = function()
                    return true
                end
            }))
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return{
                message = 'Kaboom!',
                colour = G.C.MULT,
            }
        end
        if context.joker_main then
            return{
                card = card,
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end,

    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'bubblewrap', 
    loc_txt = { 
        name = 'Bubble Wrap',
        text = {
          '{C:chips}+#1#{} Chips for each',
          '{C:attention}consumable{} in your',
          '{C:attention}consumable{} area',
        },
        
    },
    atlas = 'Jokers', 
    rarity = 1, 
    cost = 4, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 2, y = 2}, 
    config = { 
      extra = {
        chip_mod = 70
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chip_mod}} 
    end,
    calculate = function(self,card,context)
        if context.joker_main and G.consumeables.cards[1] then
            return {
                card = card,
                chip_mod = #G.consumeables.cards * card.ability.extra.chip_mod,
                message = 'Pop!',
                colour = G.C.CHIPS
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'graffiti',
    loc_txt = {
        name = 'Graffiti',
        text = {
            'Sell this card after',
            '{C:attention}#2#{} round to add {C:dark_edition}Foil{},',
            '{C:dark_edition}Holographic{}, or {C:dark_edition}Polychrome{}',
            'edition to a random {C:attention}Joker',
            '{C:inactive}(Currently {C:attention}#1#{C:inactive}/#2#)'
        },
        
    },
    atlas = 'Jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    pos = {x = 3, y = 2},
    config = {
        extra = {
            rounds = 0,
            required = 1
        }
    },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS.e_foil
        info_queue[#info_queue+1] = G.P_CENTERS.e_holo
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        return { vars = { center.ability.extra.rounds, center.ability.extra.required} }
    end,
    calculate = function(self, card, context)

        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            if card.ability.extra.rounds < card.ability.extra.required then
                card.ability.extra.rounds = card.ability.extra.rounds + 1
                if card.ability.extra.rounds >= card.ability.extra.required then
                    local eval = function(card) return (card.ability.extra.rounds >= card.ability.extra.required) end
                    juice_card_until(card, eval, true)
                    return {
                        card = card,
                        message = 'Active',
                        colour = G.C.MONEY,
                    }
                end
            end
        end

        if context.selling_self and card.ability.extra.rounds >= card.ability.extra.required and not context.blueprint then
            local eligible_editionless_jokers = {}
            for k, v in pairs(G.jokers.cards) do
                if v.ability.set == 'Joker' and not v.edition and v ~= card then
                    table.insert(eligible_editionless_jokers, v)
                end
            end
            if #eligible_editionless_jokers > 0 then
                local eligible_card = pseudorandom_element(eligible_editionless_jokers, pseudoseed('spraypaint'))
                local edition = poll_edition('wheel_of_fortune', nil, true, true)
                eligible_card:set_edition(edition, true)
                return {
                    card = card,
                    message = 'Sprayed!',
                    colour = G.C.MONEY,
                }
            end
        end
    end,
    in_pool = function(self, wawa, wawa2)
        return true
    end,
}

SMODS.Joker{
    key = 'threemusketeers', 
    loc_txt = { 
        name = 'Three Musketeers',
        text = {
          'Each scored {C:attention}3{}',
          'will earn between',
          '{C:money}$#1#{} and {C:money}$#2#{}'
        },
        
    },
    atlas = 'Jokers', 
    rarity = 1, 
    cost = 6, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 4, y = 2}, 
    config = { 
      extra = {
        min_money = 1,
        max_money = 3,
        lines = {'En garde!', 'Have at thee!', 'Let\'s dance!'}
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.min_money, center.ability.extra.max_money}} 
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 3 then
            local earned = math.random(card.ability.extra.min_money, card.ability.extra.max_money)
                return {
                    card = card,
                    dollars = earned,
                    extra = {focus = card, message = card.ability.extra.lines[earned], colour = G.C.MONEY}
                }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'corporatejoker', 
    loc_txt = { 
        name = 'Corporate Joker',
        text = {
          'This Joker gains {C:chips}+#4#{} Chips and {C:mult}+#2#{} Mult',
          'after {C:attention}Boss Blind{} is defeated,',
          'resets if any {C:attention}Blind{} is skipped',
          '{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips and {C:mult}+#1#{C:inactive} Mult)'
        },
        
    },
    atlas = 'Jokers', 
    rarity = 1, 
    cost = 5, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 5, y = 2}, 
    config = { 
      extra = {
        mult = 0,
        mult_mod = 5,
        chips = 0,
        chips_mod = 25,
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod, center.ability.extra.chips, center.ability.extra.chips_mod }} 
    end,
    calculate = function(self, card, context)
        if  G.GAME.blind.boss and context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
            return {
                card = card,
                message = 'Promoted!',
                colour = G.C.MONEY
            }
        elseif context.joker_main and card.ability.extra.mult > 0 and card.ability.extra.chips > 0 then
            return {
                card = card,
                mult_mod = card.ability.extra.mult,
                chip_mod = card.ability.extra.chips,
                message = 'Good work!',
                colour = G.C.MONEY
            }
        elseif context.skip_blind and not context.blueprint then
            card.ability.extra.mult = 0
            card.ability.extra.chips = 0
            return {
                card = card,
                message = 'Fired!',
                colour = G.C.MULT
            }
        end
    end,

    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'boxofdonuts', 
    loc_txt = { 
        name = 'Box of Donuts',
        text = {
          'For the next {C:attention}#1#{} rounds,',
          'when {C:attention}Blind{} is selected',
          'create {C:attention}1 {C:green}Uncommon{C:attention} Joker',
          '{C:inactive}(Must have room)',
        },
        
    },
    atlas = 'Jokers', 
    rarity = 2, 
    cost = 6, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = false, 
    perishable_compat = true, 
    pos = {x = 6, y = 2}, 
    config = { 
      extra = {
        remaining = 6,
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.remaining}} 
    end,
    calculate = function(self,card,context)
        if context.setting_blind then 
            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                local jokers_to_create = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
                G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
                G.E_MANAGER:add_event(Event({
                    func = function() 
                            local card = create_card('Joker', G.jokers, nil, 0.9, nil, nil, nil, 'don')
                            card:add_to_deck()
                            G.jokers:emplace(card)
                            card:start_materialize()
                            G.GAME.joker_buffer = 0
                        return true
                    end}))
            end
            if not context.blueprint then
                card.ability.extra.remaining = card.ability.extra.remaining - 1
            end
            if card.ability.extra.remaining > 0 then
                return{
                    card = card,
                    message = 'Mmm... donut...',
                    colour = G.C.MONEY
                } 
            elseif not context.blueprint then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.3, 0.4)
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                G.jokers:remove_card(self)
                                card:remove()
                                card = nil
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return{
                    card = card,
                    message = 'D\'oh!',
                    colour = G.C.MONEY
                } 
            end
        end
        
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'amethyststaff', 
    loc_txt = { 
        name = 'Amethyst Staff',
        text = {
          'When a {C:purple}Purple Seal{}',
          'is discarded, generate',
          'an extra {C:dark_edition}Negative{}',
          '{C:tarot}Tarot{} card'
        },
        
    },
    atlas = 'Jokers', 
    rarity = 2, 
    cost = 6, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 7, y = 2}, 
    config = { 
      extra = {
      }
    },
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = {key = 'purple_seal', set = 'Other'}
        info_queue[#info_queue+1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}
        return {vars = {}} 
    end,
    calculate = function(self, card, context)
        if context.discard then
            if context.other_card.seal == 'Purple' then
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'amethyst')
                            card:set_edition({negative = true}, true)
                            card:add_to_deck()
                            G.consumeables:emplace(card) 
                            return true
                        end}))
                    return {
                        card = card,
                        message = 'Presto!',
                        colour = G.C.PURPLE 
                    }
            end
        end
    end,

    in_pool = function(self,wawa,wawa2)
        for _, playing_card in pairs(G.playing_cards) do
            if playing_card.seal == 'Purple' then
                return true
            end
        end
        return false
    end,
}
SMODS.Joker{
    key = 'hunter', 
    loc_txt = { 
        name = 'Hunter',
        text = {
          "After hand is played,",
          "discard the {C:attention}2 rightmost{}", 
          "cards held in hand"
        },
        
    },
    atlas = 'Jokers', 
    rarity = 2, 
    cost = 6, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = false, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 8, y = 2}, 
    config = { 
      extra = {
        shots = 2
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.shots}} 
    end,
    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            G.E_MANAGER:add_event(Event({ func = function()
                local any_selected = false
                local _cards = {}
                for k, v in ipairs(G.hand.cards) do
                    _cards[#_cards+1] = v
                end

                for i = #_cards, math.max(#_cards - 1, 1), -1 do
                    local selected_card, card_key = _cards[i]
                    if selected_card and not selected_card.highlighted then
                        G.hand:add_to_highlighted(selected_card, true)
                        table.remove(_cards, card_key)
                        any_selected = true
                        play_sound('card1', 1)
                    end
                end

                if any_selected then
                    G.FUNCS.discard_cards_from_highlighted(nil, true)
                end

                return true
            end }))
            delay(1.4)
            return{
                message = 'Bang!',
                colour = G.C.MONEY
            }
        end
    end,

    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'wildwest',
    loc_txt = {
        name = 'Wild West',
        text = {
          "{C:attention}+1{} hand size for every",
          "{C:attention}Wild Card{} in your {C:attention}full{}", 
          "deck at the start",
          "of the round", 
          "{C:inactive}(Currently {C:attention}+#3#{C:inactive})"
        },
    },
    atlas = 'Jokers',
    rarity = 3,
    cost = 7, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = false, 
    eternal_compat = true, 
    perishable_compat = true,
    pos = {x = 9, y = 2},
    config = { 
      extra = {
        extra_hand_size = 0,
        per = 1,
        last_applied_size = 0,
        num_wilds_display = 0
      }
    },
    loc_vars = function(self,info_queue,center)

        if G.playing_cards then
            local wilds = 0
            for k, v in pairs(G.playing_cards) do
                if v.config.center.key == 'm_wild' then
                    wilds = wilds + 1
                end
            end

            center.ability.extra.num_wilds_display = math.floor(wilds / center.ability.extra.per)
        end
        
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild
        return {vars = {center.ability.extra.extra_hand_size, center.ability.extra.per, center.ability.extra.num_wilds_display}} 
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.individual and not context.repetition and not context.blueprint then
            local wilds = 0
            local isdifferent = false
            for k, v in pairs(G.playing_cards) do
                if v.config.center.key == 'm_wild' then
                    wilds = wilds + 1
                end
            end

            local bonus_size = math.floor(wilds / card.ability.extra.per)

            if bonus_size ~= card.ability.extra.last_applied_size then
                isdifferent = true
            end

            G.hand:change_size(-card.ability.extra.last_applied_size)
            G.hand:change_size(bonus_size)
            card.ability.extra.last_applied_size = bonus_size
            card.ability.extra.extra_hand_size = bonus_size

            if isdifferent then
                return{
                    message = 'Reloaded!',
                    colour = G.C.MONEY
                }
            end
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.extra_hand_size)
    end,

    remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.extra_hand_size)
	end,


    in_pool = function(self,wawa,wawa2)
        for _, playing_card in pairs(G.playing_cards) do
            if SMODS.has_enhancement(playing_card, 'm_wild') then
                return true
            end
        end
        return false
    end,
}
SMODS.Joker{
    key = 'flawlessvictory', 
    loc_txt = { 
        name = 'Flawless Victory',
        text = {
          "Earn {C:money}$#2#{} per remaining",
          "hand if blind is", 
          "defeated in {C:attention}1{} hand"
        },
        
    },
    atlas = 'Jokers', 
    rarity = 1, 
    cost = 6, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = false, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 0, y = 3}, 
    config = { 
      extra = {
        money = 0,
        money_mod = 2,
        flawless = false
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.money, center.ability.extra.money_mod, center.ability.extra.flawless}} 
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and G.GAME.current_round.hands_played <= 1 and not context.blueprint then
            card.ability.extra.flawless = true
            card.ability.extra.money = G.GAME.current_round.hands_left * card.ability.extra.money_mod
            return{
                    message = 'Too easy!',
                    colour = G.C.MONEY
            }
        end
    end,

    calc_dollar_bonus = function(self,card)
        if card.ability.extra.flawless then
            card.ability.extra.flawless = false
            return card.ability.extra.money
        end
    end,

    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'kidsdrawing', 
    loc_txt = { 
        name = 'Kids Drawing',
        text = {
          'Each scored card has',
          'a {C:green}#1# in #2#{} chance to gain',
          'a random {C:attention}Enhancement{}',
        },
        
    },
    atlas = 'Jokers', 
    rarity = 2, 
    cost = 6, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 1, y = 3}, 
    config = { 
      extra = {
        odds = 4
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {G.GAME.probabilities.normal, center.ability.extra.odds}} 
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers then
            local cen_pool = {}
            local successful = false
            for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                if v.key ~= 'm_stone' then 
                    cen_pool[#cen_pool+1] = v
                end
            end
            
            for k, v in ipairs(context.scoring_hand) do
                if pseudorandom('cray') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    successful = true
                    v:set_ability(pseudorandom_element(cen_pool, pseudoseed('cray')), nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    }))
                    G.GAME.blind:debuff_card(v) 
                end 
            end

            if successful then
                return {
                    message = 'Crayon!', 
                    colour = G.C.SECONDARY_SET.Enhanced
                }
            end
        end

    end,

    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'cruiseship', 
    loc_txt = { 
        name = 'Cruise Ship',
        text = {
          '{X:mult,C:white}X#2#{} Mult for every',
          '{C:attention}Voucher{} owned',
          '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive})'

        },
        
    },
    atlas = 'Jokers', 
    rarity = 2, 
    cost = 7, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 2, y = 3}, 
    config = { 
      extra = {
        Xmult = 1,
        Xmult_mod = 0.35
      }
    },
    loc_vars = function(self,info_queue,center)
        local vouchers_redeemed = 0
        for k, v in pairs(G.GAME.used_vouchers) do
            vouchers_redeemed = vouchers_redeemed + 1
        end
        center.ability.extra.Xmult = 1 + (vouchers_redeemed * center.ability.extra.Xmult_mod)

        return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_mod}} 
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
        if context.buying_card and context.card.ability.set == 'Voucher' and not context.blueprint then
            return {
                card = card,
                message = 'All aboard!',
                colour = G.C.BLUE
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'protestsign', 
    loc_txt = { 
        name = 'Protest Sign',
        text = {
          "Adds {C:attention}triple{} the rank",
          "of the {C:attention}#1# leftmost{} cards",
          "held in hand to Chips",
        },
        
    },
    atlas = 'Jokers', 
    rarity = 1, 
    cost = 5, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 3, y = 3}, 
    config = { 
      extra = {
        num_of_cards = 3 
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.num_of_cards}} 
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.hand and context.individual and not context.end_of_round then

            local leftmost = {}
            for i = 1, math.min(card.ability.extra.num_of_cards, #G.hand.cards) do
                if G.hand.cards[i].ability.effect ~= 'Stone Card' then
                    leftmost[G.hand.cards[i]] = true
                end
            end

            if leftmost[context.other_card] then
                return {
                    card = card,
                    chip_mod = context.other_card.base.nominal * 3,
                    message = '+' .. (context.other_card.base.nominal * 3),
                    extra = {focus = card, message = 'We want score!', colour = G.C.CHIPS},
                    colour = G.C.CHIPS
                }
            end
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'landlord', 
    loc_txt = { 
        name = 'Landlord',
        text = {
          '{X:mult,C:white}X#1#{} Mult if played hand',
          'contains a {C:attention}Full House{}, then',
          'lose {C:money}$#2#{} and add {C:money}$#2#{} to the',
          '{C:attention}Sell{} {C:attention}Value{} of this card'
        },
        
    },
    atlas = 'Jokers', 
    rarity = 3, 
    cost = 7, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 4, y = 3}, 
    config = { 
      extra = {
        Xmult = 3.5,
        money = 1,
        lines = {'Rent due!', 'Pay up!', 'Final notice!'}
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.money}} 
    end,
    calculate = function(self,card,context)
        if context.before and context.poker_hands and next(context.poker_hands["Full House"]) and not context.blueprint then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.money
            card:set_cost()
            return {
                card = card,
                dollars = card.ability.extra.money * -1,
                message = pseudorandom_element(card.ability.extra.lines, pseudoseed('land')),
                colour = G.C.MONEY
            }
        end
        if context.joker_main and context.poker_hands and next(context.poker_hands["Full House"]) then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        
        return true
    end,
}
SMODS.Joker{
    key = 'lockpick',
    loc_txt = {
        name = 'Lock Pick',
        text = {
          'Skipping any {C:attention}Blind{} generates',
          '{C:green}#1#{} other random {C:attention}tag(s){}.',
          'Number of {C:attention}tags{}',
          'increases with each level',
          '{C:inactive}Next level in ({C:attention}#3#{}{C:inactive}/#2#) skips'
        },
    },
    atlas = 'Jokers',
    rarity = 2, 
    cost = 7,
    unlocked = true, 
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 5, y = 3}, 
    config = { 
      extra = {
        tags = 1,
        required = 1,
        picked = 0
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.tags, center.ability.extra.required, center.ability.extra.picked}} 
    end,
    calculate = function(self,card,context)
        if context.skip_blind then
            local tag_pool = get_current_pool('Tag')
            local list_of_tags = {}
            for i = 1, card.ability.extra.tags do
                local tag = pseudorandom_element(tag_pool, pseudoseed('lock'))

                while tag == 'UNAVAILABLE' do
                    tag = pseudorandom_element(tag_pool, pseudoseed('lock'))
                end

                list_of_tags[i] = tag
            end

            G.E_MANAGER:add_event(Event({
                func = (function()
                    for _, tag_key in pairs(list_of_tags) do
                        local tag = Tag(tag_key)
                        if tag_key == "tag_orbital" then
                            local available_handtypes = {}

                            for k, hand in pairs(G.GAME.hands) do
                                if hand.visible then
                                    available_handtypes[#available_handtypes + 1] = k
                                end
                            end

                            tag.ability.orbital_hand = pseudorandom_element(available_handtypes, pseudoseed('lock'))
                        end

                        add_tag(tag)
                        if context.blueprint then 
                            context.blueprint_card:juice_up(0.3, 0.4) 
                        else 
                            card:juice_up(0.3, 0.4) 
                        end
                        play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    end
                    return true
                end)
            }))
            if not context.blueprint then
                card.ability.extra.picked = card.ability.extra.picked + 1
            end
            
            if card.ability.extra.picked >= card.ability.extra.required and not context.blueprint then
                card.ability.extra.tags = card.ability.extra.tags + 1
                card.ability.extra.required = card.ability.extra.tags
                card.ability.extra.picked = 0
                return {
                    card = card,
                    message = 'Lockpicking increased!',
                    colour = G.C.GREEN
                }
            end
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'squirrel', 
    loc_txt = { 
        name = 'Squirrel',
        text = {
          '{C:chips}+#1#{} Chips. Sell this',
          'card during a {C:attention}Blind{}',
          'to replace it with',
          'a {C:blue}Common{} Joker',
        },
        
    },
    atlas = 'Jokers', 
    rarity = 1, 
    cost = 3, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = false, 
    perishable_compat = true, 
    pos = {x = 6, y = 3}, 
    config = { 
      extra = {
        chips = 15,
        canBeSacrificed = false
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips}} 
    end,
    calculate = function(self,card,context)

        if G.GAME.blind.in_blind and not card.ability.extra.canBeSacrificed and not context.blueprint then
			card.ability.extra.canBeSacrificed = true
            local eval = function(card) return (card.ability.extra.canBeSacrificed == true) end
            juice_card_until(card, eval, true)
            return{
                message = 'Please...',
                card = card,
                colour = G.C.BLACK
            }
		end

		if not G.GAME.blind.in_blind and card.ability.extra.canBeSacrificed and not context.blueprint then
			card.ability.extra.canBeSacrificed = false
            return{
                message = 'Thank you!',
                card = card,
                colour = G.C.BLACK
            }
		end

        if context.selling_self and card.ability.extra.canBeSacrificed then
            G.E_MANAGER:add_event(Event({
                func = function() 
                        local card = create_card('Joker', G.jokers, nil, 0.5, nil, nil, nil, 'dra')
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        card:start_materialize()
                    return true
                end}))  
            return {
                card = card,
                message = 'Sacrificed!',
                colour = G.C.RED,
            }

        elseif context.joker_main then
            return {
                card = card,
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'diamondarmor',
    loc_txt = {
        name = 'Diamond Armor',
        text = {
          'After scoring {C:attention}#2#{} cards with',
          '{C:diamonds}Diamond{} suit {C:inactive}[#1#]{} this joker',
          'activates, and will prevent',
          'death up to {C:attention}#3#{} times if chips scored',
          'are at least {C:attention}20%{} of required chips',
        },
    },
    atlas = 'Jokers',
    rarity = 3, 
    cost = 8,
    unlocked = true, 
    discovered = true, 
    blueprint_compat = false, 
    eternal_compat = false, 
    perishable_compat = false, 
    pos = {x = 7, y = 3}, 
    config = { 
      extra = {
        diamonds = 0,
        required = 24,
        lives = 2,
        active = false,
        min_score = 20
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.diamonds, center.ability.extra.required, center.ability.extra.lives, center.ability.extra.active}} 
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Diamonds") and card.ability.extra.diamonds < card.ability.extra.required and not context.blueprint then
            card.ability.extra.diamonds = card.ability.extra.diamonds + 1 
            return {
                card = card,
                extra = {focus = card, message = "Crafting!", colour = G.C.BLUE},
                colour = G.C.BLUE
            }
        end

        if context.joker_main and card.ability.extra.diamonds >= card.ability.extra.required and card.ability.extra.active == false and not context.blueprint then
            card.ability.extra.active = true
            return {
                message = 'Release!',
                colour = G.C.BLUE
            } 
        end 

        if context.end_of_round and not context.blueprint and context.game_over and card.ability.extra.diamonds >= card.ability.extra.required and G.GAME.chips/G.GAME.blind.chips >= 0.2 then
            card.ability.extra.lives = card.ability.extra.lives - 1
            if card.ability.extra.lives <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        card:start_dissolve()
                        return true
                    end
                })) 
            end
            
            return {
                message = 'Comin in hot!',
                saved = 'diamond_armor_saved',
                colour = G.C.BLUE
            }  
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'climbthemountain',
    loc_txt = {
        name = 'Climb the Mountain',
        text = {
          'This Joker gains {C:mult}+#2#{} Mult',
          'for each scored {C:attention}#4#{}, rank',
          'increases every round',
          '{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)',
        },
    },
    atlas = 'Jokers',
    rarity = 1, 
    cost = 6,
    unlocked = true, 
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 8, y = 3}, 
    config = { 
      extra = {
        mult = 0,
        mult_mod = 2,
        current_rank_id = 2,
        current_rank_value = '2'
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod, center.ability.extra.current_rank_id, center.ability.extra.current_rank_value}} 
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() ==  card.ability.extra.current_rank_id and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return {
                card = card,
                extra = {focus = card, message = "Upgrade!", colour = G.C.MULT},
                colour = G.C.MULT
            }
        end

        if context.joker_main  then
            return {
                card = card,
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult,
                colour = G.C.MULT
            }
        end 

        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            if card.ability.extra.current_rank_id >= 14 then
                card.ability.extra.current_rank_id = 2
            else
                card.ability.extra.current_rank_id = card.ability.extra.current_rank_id + 1
            end

            if card.ability.extra.current_rank_id == 14 then
                card.ability.extra.current_rank_value = 'Ace'
            elseif card.ability.extra.current_rank_id == 13 then
                card.ability.extra.current_rank_value = 'King'
            elseif card.ability.extra.current_rank_id == 12 then
                card.ability.extra.current_rank_value = 'Queen'
            elseif card.ability.extra.current_rank_id == 11 then
                card.ability.extra.current_rank_value = 'Jack'
            else
                card.ability.extra.current_rank_value = card.ability.extra.current_rank_id
            end

            return {
                card = card,
                message = 'Climb!',
                colour = G.C.BLUE
            }
            
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'blackrose', 
    loc_txt = { 
        name = 'Black Rose',
        text = {
          "Retrigger all",
          "played cards with",
          "{C:spades}Spade{} suit"
        },
        
    },
    atlas = 'Jokers', 
    rarity = 2, 
    cost = 6, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 9, y = 3}, 
    config = { 
      extra = {
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {}} 
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.play and context.repetition and context.other_card:is_suit("Spades") then
            return {
                card = card,
                repetitions = 1,
                message = 'Decay...', 
                colour = G.C.BLACK
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'angel&devil', 
    loc_txt = { 
        name = 'Angel & Devil',
        text = {
          "When {C:attention}Blind{} is selected,",
          "gain {C:blue}+#1#{} Hand or",
          "gain {C:red}+#2#{} Discard",
        },
        
    },
    atlas = 'Jokers', 
    rarity = 2, 
    cost = 6, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 0, y = 4}, 
    config = { 
      extra = {
        extra_hands = 1,
        extra_discards = 1
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.extra_hands, center.ability.extra.extra_discards}} 
    end,
    calculate = function(self,card,context)
        if context.setting_blind then
            if math.random(1, 2) == 1 then
                G.E_MANAGER:add_event(Event({func = function()
                    ease_hands_played(card.ability.extra.extra_hands)
                return true end }))
                return {
                    card = card,
                    message = 'Angel!', 
                    colour = G.C.BLUE
                }
            else
                G.E_MANAGER:add_event(Event({func = function()
                    ease_discard(card.ability.extra.extra_discards)
                return true end }))
                return {
                    card = card,
                    message = 'Devil!', 
                    colour = G.C.RED
                }

            end
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'snakeeyes', 
    loc_txt = { 
        name = 'Snake Eyes',
        text = {
          "Cuts all {C:attention}listed",
          "{C:green,E:1,S:1.1}probabilities{} in half.",
          "{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}0.5 in 3{C:inactive})",
          "{C:green}#1# in #2#{} chance to gain {C:chips}+#4#{}",
          "Chips when hand is played",
          "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)"
        },
        
    },
    atlas = 'Jokers', 
    rarity = 1, 
    cost = 3, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 1, y = 4}, 
    config = { 
      extra = {
        odds = 6,
        chips = 0,
        chips_mod = 36
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {G.GAME.probabilities.normal, center.ability.extra.odds, center.ability.extra.chips, center.ability.extra.chips_mod }} 
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.jokers and context.before and not context.blueprint and pseudorandom('snak') < G.GAME.probabilities.normal / card.ability.extra.odds then 
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
            return {
                card = card,
                message = 'Snake Eyes!',
                colour = G.C.CHIPS
            }
        elseif context.joker_main then
            return {
                card = card,
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do 
            G.GAME.probabilities[k] = v/2
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do 
            G.GAME.probabilities[k] = v*2
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'bruce', 
    loc_txt = { 
        name = 'Bruce',
        text = {
          "When {C:attention}Blind{} is selected, gain",
          "{X:mult,C:white} X#2# {} Mult and {C:attention}destroy{} a random",
          "{C:attention}consumable{}. If there are no consumables,",
          "{C:attention}destroy{} a random Joker instead",
          "{C:inactive}(Must consume something to scale){}",
          "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive})"
        },
    },
    atlas = 'Jokers', 
    rarity = 3, 
    cost = 8, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 2, y = 4}, 
    config = { 
      extra = {
        Xmult = 1,
        Xmult_mod = 0.25
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_mod}} 
    end,
    calculate = function(self,card,context)
        if not context.blueprint and context.setting_blind then

            local consumable_to_destroy = pseudorandom_element(G.consumeables.cards, pseudoseed('bruce'))
            
            local destructable_jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not G.jokers.cards[i].ability.eternal and not G.jokers.cards[i].getting_sliced then destructable_jokers[#destructable_jokers+1] = G.jokers.cards[i] end
            end
            local joker_to_destroy = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('bruce')) or nil

            if consumable_to_destroy ~= nil then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up(0.8, 0.8)
                        consumable_to_destroy:juice_up(0.3, 0.4)
                        consumable_to_destroy:start_dissolve()
                        play_sound('slice1', 0.96+math.random()*0.08)
                        return true
                    end
                }))
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
                return {
                    card = card,
                    message = 'X' .. card.ability.extra.Xmult,
                    colour = G.C.MULT
                }
            end

            if joker_to_destroy and not consumable_to_destroy then
                joker_to_destroy.getting_sliced = true 
                G.E_MANAGER:add_event(Event({func = function()
                    card:juice_up(0.8, 0.8)
                    joker_to_destroy:juice_up(0.3, 0.4)
                    joker_to_destroy:start_dissolve({G.C.RED}, nil, 1.6)
                    play_sound('slice1', 0.96+math.random()*0.08)
                return true end }))
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
                return {
                    card = card,
                    message = 'X' .. card.ability.extra.Xmult,
                    colour = G.C.MULT
                }
            end
            
            
        end

        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'fox', 
    loc_txt = { 
        name = 'Fox',
        text = {
          'Adds {C:dark_edition}Polychrome{} edition',
          'to first scored card'
        },
        
    },
    atlas = 'Jokers', 
    rarity = 4, 
    cost = 20, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = false, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 3, y = 4}, 
    soul_pos = { x = 4, y = 4},
    config = { 
      extra = {
      }
    },
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        return {vars = {}} 
    end,
    add_to_deck = function(self, card, context)
        play_sound('rgl_rainbow', 1, 6)
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and not context.blueprint then
            if context.scoring_hand[1] then
                context.scoring_hand[1]:set_edition('e_polychrome', true)

                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.scoring_hand[1]:juice_up()
                        return true
                    end
                }))
            end

            return {
                message = 'Rainbow!', 
                colour = G.C.SECONDARY_SET.Enhanced
            }
        end
    end,

    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'regal', 
    loc_txt = { 
        name = 'Regal',
        text = {
          'When entering the',
          '{C:attention}shop{}, {C:attention}#1#{} random',
          '{C:attention}purchasables{}',
          'become free'
        },
        
    },
    atlas = 'Jokers', 
    rarity = 4, 
    cost = 20, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = false, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 5, y = 4},
    soul_pos = { x = 6, y = 4}, 
    config = { 
      extra = {
        free_items = 3
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.free_items}} 
    end,
    add_to_deck = function(self, card, context)
        play_sound('rgl_heyguysitsmeregal', 1, 6)
    end,
    calculate = function(self, card, context)
        if context.starting_shop and not context.blueprint then
            G.E_MANAGER:add_event(Event({func = function()
                local shop_items = {}
                for k, v in pairs(G.I.CARD) do
                    if (v.area == G.shop_jokers or v.area == G.shop_booster or v.area == G.shop_vouchers) and v.set_cost then 
                        shop_items[#shop_items + 1] = v
                    end
                end

                local selected_items = {}
                for i = 1, math.min(card.ability.extra.free_items, #shop_items) do
                    local item = pseudorandom_element(shop_items, pseudoseed('regal'))
                    selected_items[#selected_items+1] = item

                    for j = #shop_items, 1, -1 do
                        if shop_items[j] == item then
                            table.remove(shop_items, j)
                            break
                        end
                    end
                end

                for k, v in pairs(selected_items) do
                    if (v.area == G.shop_jokers or v.area == G.shop_booster or v.area == G.shop_vouchers) and v.set_cost then 
                        v.cost = 0 
                    end
                end
                return true 
            end }))
            return {
                message = 'Free!', 
                colour = HEX("FFc0cb")
            }
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            for k, v in pairs(G.I.CARD) do
                if v.set_cost then v:set_cost() end
            end
        return true end }))
    end,

    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'spaceprincess', 
    loc_txt = { 
        name = 'Space Princess',
        text = {
          "{C:green}#1# in #2#{} chance for each",
          "played {C:attention}Queen{} to create a",
          "{C:planet}Planet{} card when scored",
          "{C:inactive}(Must have room)",
        },
        
    },
    atlas = 'Jokers', 
    rarity = 1, 
    cost = 4, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 0, y = 5}, 
    config = { 
      extra = {
        odds = 2
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {G.GAME.probabilities.normal, center.ability.extra.odds}}
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 12 and pseudorandom('rosalina') < G.GAME.probabilities.normal / card.ability.extra.odds then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                return {
                    extra = {focus = card, message = 'Stars!', colour = G.C.BLUE, func = function()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.0,
                            func = (function()
                                    local card = create_card('Planet',G.consumeables, nil, nil, nil, nil, nil, 'rosa')
                                    card:add_to_deck()
                                    G.consumeables:emplace(card)
                                    G.GAME.consumeable_buffer = 0
                                return true
                            end)}))
                    end},
                    card = card
                }
            end
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'buriedtreasure', 
    loc_txt = { 
        name = 'Buried Treasure',
        text = {
          "Earn {C:money}$#1#{} for each",
          "played {V:1}#2#{} rank,",
          "rank is hidden and",
          "changes every round",
        },
    },
    atlas = 'Jokers', 
    rarity = 1, 
    cost = 6, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 8, y = 4}, 
    config = { 
      extra = {
        money = 6,
        revealed_rank = "X",
        current_colour = G.C.RED
      }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.money, center.ability.extra.revealed_rank, colours = {center.ability.extra.current_colour}}}
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and context.other_card.base.value == G.GAME.current_round.treasure_rank.rank then
            card.ability.extra.revealed_rank = G.GAME.current_round.treasure_rank.rank
            card.ability.extra.current_colour = G.C.FILTER
            return {
                card = card,
                dollars = card.ability.extra.money,
                extra = {focus = card, message = "Treasure!", colour = G.C.MONEY}
            }
        end

        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            card.ability.extra.revealed_rank = "X"
            card.ability.extra.current_colour = G.C.RED
        end
        
    end,
    in_pool = function(self,wawa,wawa2)
        return false
    end,
}
SMODS.Joker{
    key = 'hybridjoker', 
    loc_txt = { 
        name = 'Hybrid Joker',
        text = {
          "If {C:attention}first discard{} of round",
          "has only {C:attention}2{} cards, add a",
          "{C:attention}Hybridized{} card to your hand",
        },
        
    },
    atlas = 'Jokers', 
    rarity = 3, 
    cost = 8, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 8, y = 4}, 
    config = { 
      extra = {
      }
    },
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = {key = 'hybridized_card', set = 'Other'}
        return {vars = {}} 
    end,
    calculate = function(self, card, context)

        if context.first_hand_drawn and not context.blueprint then
            local eval = function(card) return (G.GAME.current_round.discards_used <= 0 and not G.RESET_JIGGLES) end
            juice_card_until(card, eval, true)
        end

        if context.pre_discard then
            if  G.GAME.current_round.discards_used <= 0 and #context.full_hand == 2 then
                local _suits = {}
                local _ranks = {}
                local _enhancements = {}
                local _seals = {}
                local _editions = {}
                for k, v in ipairs(context.full_hand) do
                    table.insert(_suits, v.base.suit)
                    table.insert(_ranks, v.base.value)
                    if v.config.center ~= G.P_CENTERS.c_base then
                        table.insert(_enhancements, v.config.center)
                    end
                    if v.seal ~= nil then
                        table.insert(_seals, v.seal)
                    end
                    if v.edition ~= nil then
                        table.insert(_editions, v.edition)
                    end
                end

                G.E_MANAGER:add_event(Event({
                    func = function()
                        local _suit = pseudorandom_element(_suits, pseudoseed('suhybr'))
                        local _rank = pseudorandom_element(_ranks, pseudoseed('rhybr'))
                        local _enhancement = (pseudorandom_element(_enhancements, pseudoseed('enhybr')) or G.P_CENTERS.c_base)
                        local _seal = (pseudorandom_element(_seals, pseudoseed('sehybr')) or nil)
                        local _edition = (pseudorandom_element(_editions, pseudoseed('edhybr')) or nil)
                        local new_card = create_playing_card({front = G.P_CARDS['S_A'], center = _enhancement}, G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                        SMODS.change_base(new_card, _suit, _rank)
                        new_card:set_seal(_seal, true)
                        new_card:set_edition(_edition, true, true)
                        playing_card_joker_effects({true})
                        return true
                    end
                }))

                return {
                    message = 'Hybridized!', 
                    colour = G.C.BLUE
                }
            end
        end
    end,

    in_pool = function(self,wawa,wawa2)
        return false
    end,
}
SMODS.Joker{
    key = 'sapphirestaff',
    loc_txt = {
        name = 'Sapphire Staff',
        text = {
          "{C:green}#1# in #2#{} chance to",
          "upgrade level of",
          "played {C:attention}poker hand{}",
          "if a {C:blue}Blue Seal{} is",
          "held in hand"
        },
        
    },
    atlas = 'Jokers',
    rarity = 2, 
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    pos = {x = 3, y = 5}, 
    config = { 
      extra = {
        odds = 3,
      }
    },
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = {key = 'blue_seal', set = 'Other'}
        return {vars = {G.GAME.probabilities.normal, center.ability.extra.odds}}
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers then
            local function hasBlueSeal()
                for k, v in ipairs(G.hand.cards) do
                    if v.seal == 'Blue' then
                        return true
                    end
                end
                return false
            end

            if hasBlueSeal() and pseudorandom('sapp') < G.GAME.probabilities.normal / card.ability.extra.odds then
                level_up_hand(context.blueprint_card or card, context.scoring_name, nil, 1)

                return {
                    card = card,
                    message = 'Voilà!',
                    colour = G.C.BLUE
                }
            end
            
            
        end
        
    end,

    in_pool = function(self,wawa,wawa2)
        for _, playing_card in pairs(G.playing_cards) do
            if playing_card.seal == 'Blue' then
                return true
            end
        end
        return false
    end,
}
SMODS.Joker{
    key = 'cityoftears', 
    loc_txt = { 
        name = 'City of Tears',
        text = {
          "If played hand has",
          "a scoring {C:clubs}Club{} card,",
          "every card held in hand",
          "permanently gains {C:chips}+#1#{} Chips",
        },
        
    },
    atlas = 'Jokers', 
    rarity = 2, 
    cost = 5, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 8, y = 4}, 
    config = { 
      extra = {
        tear_chips = 5
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.tear_chips}} 
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers then
            local function hasClubs()
                for k, v in ipairs(context.scoring_hand) do
                    if v:is_suit("Clubs") then
                        return true
                    end
                end
                return false
            end

            if hasClubs() then
                for k, v in ipairs(G.hand.cards) do
                    v.ability.perma_bonus = v.ability.perma_bonus or 0
                    v.ability.perma_bonus = v.ability.perma_bonus + card.ability.extra.tear_chips
                end

                return {
                    card = card,
                    message = 'Tears...',
                    colour = G.C.BLUE
                }
            end
        end
    end,

    in_pool = function(self,wawa,wawa2)
        return false
    end,
}
SMODS.Joker{
    key = 'jokle', 
    loc_txt = { 
        name = 'Jokle',
        text = {
          "Jokers with the word",
          "{C:attention}Joker{} in their name",
          "each give {X:mult,C:white} X#1# {} Mult",
        },
        
    },
    atlas = 'Jokers', 
    rarity = 2, 
    cost = 6, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 5, y = 5}, 
    config = { 
      extra = {
        Xmult = 1.5
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} 
    end,
    calculate = function(self, card, context)
        if context.other_joker then 
            if string.find(context.other_joker.config.center.name:lower(), "joker") then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.other_joker:juice_up(0.5, 0.5)
                        return true
                    end
                })) 
                return {
                    Xmult_mod = card.ability.extra.Xmult,
                    message = 'Jokle!',
                    colour = G.C.MULT
                }
            end
        end
    end,

    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'page', 
    loc_txt = { 
        name = 'Page',
        text = {
          "Earn {C:money}$#1#{} when adding",
          "a {C:attention}playing card{} to your deck,",
          "this joker is destroyed after",
          "adding {C:attention}8{} or more cards",
          "{C:inactive}(Currently {C:attention}#2#{C:inactive}/8)"
        },
        
    },
    atlas = 'Jokers', 
    rarity = 2, 
    cost = 6, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = false, 
    perishable_compat = true, 
    pos = {x = 6, y = 5}, 
    config = { 
      extra = {
        money = 5,
        pages = 0,
        lines = {'Follows...', 'Always watches...', 'Don\'t look...', 'Can\'t run...', 'Leave me alone...', 'Help me...', 'NO NO NO NO NO NO'}
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.money, center.ability.extra.pages}} 
    end,
    calculate = function(self, card, context)
        if context.playing_card_added and context.cards and context.cards[1] then
            if not context.blueprint then
                card.ability.extra.pages = card.ability.extra.pages + #context.cards
            end
            
            if card.ability.extra.pages < 8 then
                return {
                    card = card,
                    extra = {focus = card, message = (pseudorandom_element(card.ability.extra.lines, pseudoseed('slender')) or nil), colour = G.C.BLACK},
                    dollars = card.ability.extra.money * #context.cards
                }
            else 
                return {
                    card = card,
                    extra = {focus = card},
                    dollars = card.ability.extra.money * #context.cards
                }
            end 
            
            
        end

        if not context.blueprint then
            if card.ability.extra.pages >= 8 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                G.jokers:remove_card(self)
                                card:remove()
                                card = nil
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = '...',
                    colour = G.C.BLACK
                }
            end
        end
    end,

    in_pool = function(self,wawa,wawa2)
        return true
    end,
}

--[[SMODS.Joker{
    key = 'burntothegroundguy', 
    loc_txt = { 
        name = 'BURN TO THE GROUND',
        text = {
          'Sell or destroy this card to',
          'create {C:attention}2{} free',
          '{C:attention}BURN TO THE GROUND',
        },
        
    },
    atlas = 'Jokers', 
    rarity = 4, 
    cost = 20, 
    unlocked = true,  
    discovered = true, 
    blueprint_compat = false, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 0, y = 5},
    config = { 
      extra = {
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {}} 
    end,
    BURN = function(self, card, context)
        if math.random(1, 2) == 1 then
            play_sound('rgl_burntotheground', 1, 6)
        else
            play_sound('rgl_burn', 1, 6)
        end
         
    end,
    add_to_deck = function(self, card, context)
        self:BURN(card, context)
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return{
                self:BURN(card, context)
            }
        end
    end,
    remove_from_deck = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function() 
                SMODS.add_card({set = 'Joker', area = G.jokers, key = 'j_rgl_burntothegroundguy'})
                SMODS.add_card({set = 'Joker', area = G.jokers, key = 'j_rgl_burntothegroundguy'})
            return true
        end}))
          
    end,

    in_pool = function(self,wawa,wawa2)
        
        return false
    end,
}]]






SMODS.Back{
	key = "pinkdeck",  
    loc_txt = {      
        name = 'Pink Deck',      
        text = {
          "{C:attention}Regals Mod{}",
          "Jokers appear",
          "{C:attention}5x{} more often",
        } 
    }, 
    atlas = "Decks",
    order = 16,
    unlocked = true,
    discovered = true,
    pos = { x = 0, y = 0 },
	config = {},
    loc_vars = function(self, info_queue, center)
        return {vars = {}}
    end,
	
	
    apply = function(self, back)
       
    end,

    calculate = function(self, back, context)
    
    end
}
SMODS.Back{
	key = "luckydeck",  
    loc_txt = {      
        name = 'Lucky Deck',      
        text = {
          "Doubles all {C:attention}listed",
          "{C:green,E:1,S:1.1}probabilities{}, start",
          "run with {C:tarot}Magician{}"
        } 
    }, 
    atlas = "Decks",
    order = 17,
    unlocked = true,
    discovered = true,
    pos = { x = 1, y = 0 },
	config = {consumables = {'c_magician'}},
    loc_vars = function(self, info_queue, center)
        return {vars = {}}
    end,
	
	
    apply = function(self, back)
        for k, v in pairs(G.GAME.probabilities) do 
            G.GAME.probabilities[k] = v*2
        end
    end,

    calculate = function(self, back, context)
        
    end
}
SMODS.Back{
	key = "collectorsdeck",  
    loc_txt = {      
        name = 'Collectors Deck',      
        text = {
          "Start run with",
          "{C:attention}Hone{} and {C:attention}Glow up{},",
          "{C:attention}+1{} booster pack per shop",
        } 
    }, 
    atlas = "Decks",
    order = 18,
    unlocked = true,
    discovered = true,
    pos = { x = 4, y = 0 },
	config = {vouchers = {'v_hone', 'v_glow_up'}},
    loc_vars = function(self, info_queue, center)
        return {vars = {}}
    end,
	
	
    apply = function(self, back)
        SMODS.change_booster_limit(1)
    end,

    calculate = function(self, back, context)
    
    end
}
SMODS.Back{
	key = "hivedeck",  
    loc_txt = {      
        name = 'Hive Deck',      
        text = {
          "Start run with {C:attention}26{} cards",
          "of 2 random {C:attention}Suits{},",
          "{C:red}-1{} hand size",
          "and {C:red}-1{} discard"
        } 
    }, 
    atlas = "Decks",
    order = 19,
    unlocked = true,
    discovered = true,
    pos = { x = 3, y = 0 },
	config = {discards = -1},
    loc_vars = function(self, info_queue, center)
        return {vars = {}}
    end,

    apply = function(self, back)
        local suits = {'Spades', 'Hearts', 'Clubs', 'Diamonds'}

        local suit1 = pseudorandom_element(suits)
        local remaining_suits = {}
        for k, v in ipairs(suits) do
            if v ~= suit1 then
                table.insert(remaining_suits, v)
            end
        end
        local suit2 = pseudorandom_element(remaining_suits)

        G.E_MANAGER:add_event(Event({
            func = function()
                local cards_to_remove = {}
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit ~= suit1 and v.base.suit ~= suit2 then
                        table.insert(cards_to_remove, v)
                    end
                end

                for k, v in ipairs(cards_to_remove) do
                    v:remove()
                end

                G.hand:change_size(-1)
                G.GAME.starting_deck_size = #G.playing_cards
                return true
            end
        }))
    end,


    calculate = function(self, back, context)
    
    end
}
SMODS.Back{
	key = "companiondeck",  
    loc_txt = {      
        name = 'Companion Deck',      
        text = {
          "Start run with",
          "{C:tarot}Soul{}, {C:red}-1{} card slots",
          "in the shop and",
          "rerolls cost {C:money}$2{} more"
        } 
    }, 
    atlas = "Decks",
    order = 20,
    unlocked = true,
    discovered = true,
    pos = { x = 2, y = 0 },
	config = {consumables = {'c_soul'}},
    loc_vars = function(self, info_queue, center)
        return {vars = {}}
    end,
	
	
    apply = function(self, back)
        change_shop_size(-1)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + 2
                G.GAME.current_round.reroll_cost = G.GAME.current_round.reroll_cost + 2
                return true
            end
        }))
        
    end,

    calculate = function(self, back, context)
    
    end
}

function reset_treasure_rank()
    G.GAME.current_round.treasure_rank.rank = 'Ace'
    local valid_treasure_cards = {}
    for k, v in ipairs(G.playing_cards) do
        if v.key ~= 'm_stone' then
            valid_treasure_cards[#valid_treasure_cards+1] = v
        end
    end
    if valid_treasure_cards[1] then 
        local treasure_card = pseudorandom_element(valid_treasure_cards, pseudoseed('treasure'..G.GAME.round_resets.ante))
        G.GAME.current_round.treasure_rank.rank = treasure_card.base.value
        G.GAME.current_round.treasure_rank.id = treasure_card.base.id
    end
end


SMODS.Sound({
	key = "heyguysitsmeregal",
	path = "hey guys its me regal.ogg",
})
SMODS.Sound({
	key = "rainbow",
	path = "RAINBOW.ogg",
})
--[[SMODS.Sound({
	key = "burn",
	path = "burn-made-with-Voicemod.ogg",
})
SMODS.Sound({
	key = "burntotheground",
	path = "burn-to-the-ground-made-with-Voicemod.mp3",
})]]
    
mod.reset_game_globals = function(run_start)
	reset_treasure_rank()
end
    
