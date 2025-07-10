--- STEAMODDED HEADER
--- MOD_NAME: Regals Mod
--- MOD_ID: REGALSMOD
--- MOD_AUTHOR: [Liam Hutchinson]
--- MOD_DESCRIPTION: this is my attempt at creating a joker mod for balatro.
--- PREFIX: rgl
----------------------------------------------
------------MOD CODE -------------------------


SMODS.Atlas{
    key = 'Jokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'collegejoker', --joker key
    loc_txt = { -- local text
        name = 'College Joker',
        text = {
          '{X:mult,C:white}X#1#{} Mult if hand',
          'is played while',
          'in debt or at {C:money}$0{}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 7, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 4 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.joker_main and G.GAME.dollars <= 0 then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'valentinesdaygift', --joker key
    loc_txt = { -- local text
        name = 'Valentines Day Gift',
        text = {
          'Each {C:hearts}Heart{} card',
          'held in hand',
          'scores {C:mult}+#1#{} mult'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 6 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.hand and context.individual and not context.end_of_round and context.other_card:is_suit("Hearts") then
            return {
                card = card,
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'cottoncandy', --joker key
    loc_txt = { -- local text
        name = 'Cotton Candy',
        text = {
          'Sell this card to',
          'create {C:attention}2{} free',
          '{C:attention}Voucher Tags',
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 2, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 5 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.selling_self then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_voucher'))
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_voucher'))
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'artisticjoker', --joker key
    loc_txt = { -- local text
        name = 'Artistic Joker',
        text = {
          '{C:mult}+#2#{} mult per',
          'hand size',
          '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 3, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 16, --configurable value
        mult_mod = 2
      }
    },
    loc_vars = function(self,info_queue,center)
        if G.hand and G.hand.config and G.hand.config.card_limit then
            center.ability.extra.mult = G.hand.config.card_limit * center.ability.extra.mult_mod  
        end
        return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if G.hand and G.hand.config and G.hand.config.card_limit then
            card.ability.extra.mult = G.hand.config.card_limit * card.ability.extra.mult_mod  
        end
        if context.joker_main then
            return {
                card = card,
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'spinningtop', --joker key
    loc_txt = { -- local text
        name = 'Spinning Top',
        text = {
          'Create a {C:attention}The Wheel of Fortune{}',
          '{C:tarot}Tarot{} card at the end of the', 
          '{C:attention}Shop{} {C:inactive}(Must have room)',
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 4, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {}} --#1# is replaced with card.ability.extra.Xmult
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
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})                       
                            return true
                        end)}))
                end
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'mushroom', --joker key
    loc_txt = { -- local text
        name = 'Mushroom',
        text = {
          'Levels up the next',
          '{C:attention}#1#{} hands played'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 5, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        remaining = 4
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.remaining}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self, card, context)
        if context.before then
            level_up_hand(context.blueprint_card or card, context.scoring_name, nil, 1)
            if not context.blueprint then
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
                        message = localize('k_eaten_ex'),
                        colour = G.C.MONEY
                    }
                end
            end

            if not context.blueprint then
                return {
                    card = card,
                    message = '-1',
                    colour = G.C.MULT
                }
            end
        end
    end,

    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'tubbyjoker', --joker key
    loc_txt = { -- local text
        name = 'Tubby Joker',
        text = {
          'This Joker gains {C:mult}+#2#{} Mult',
          'if played hand contains',
          '{C:attention}5 scoring cards',
          '{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 6, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 0,
        mult_mod = 2
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and #context.scoring_hand == 5 and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return {
                card = card,
                message = 'Upgrade',
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
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = '3djoker', --joker key
    loc_txt = { -- local text
        name = '3D Joker',
        text = {
          "{C:attention}Bonus Cards{} also",
          "score {C:mult}+#2# mult{}.",
          "{C:attention}Mult Cards{} also",
          "score {C:chips}+#1# chips{}"
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 4, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 7, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chips_mod = 60,
        mult_mod = 8
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips_mod, center.ability.extra.mult_mod}} --#1# is replaced with card.ability.extra.Xmult
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
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'inkbottle', --joker key
    loc_txt = { -- local text
        name = 'Ink Bottle',
        text = {
          "Converts the next",
          "{C:attention}#1#{} scored cards",
          "into {C:spades}Spades{}"
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 8, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        remaining = 16
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.remaining}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers then
            for k, v in ipairs(context.scoring_hand) do
                if card.ability.extra.remaining > 0 then
                    card.ability.extra.remaining = card.ability.extra.remaining - 1 
                    v.change_suit(v, 'Spades')
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    })) 
                end
            end
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
                    message = 'Used up!',
                    colour = G.C.MONEY
                }
            end
            return {message = 'Spades', colour = G.C.SUITS['Spades']}
        end
    end,

    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'phoenix', --joker key
    loc_txt = { -- local text
        name = 'Phoenix',
        text = {
          'When {C:attention}Blind{} is selected,',
          'generate a {C:tarot}Tarot{} or {C:planet}Planet{} card.', 
          '{C:green}#1# in #2#{} chance to also generate',
          'a {C:spectral}Spectral{} card {C:inactive}(Must have room)'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 8, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 9, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        odds = 3
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {G.GAME.probabilities.normal, center.ability.extra.odds}} --#1# is replaced with card.ability.extra.Xmult
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
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})                       
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
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.PURPLE})                       
                            return true
                        end)}))
                end
            
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'welfare', --joker key
    loc_txt = { -- local text
        name = 'Welfare',
        text = {
          'If money is under',
          '{C:money}$#1#{} when round',
          'ends, earn {C:money}$#2#{}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        money_cap = 15,
        money = 5
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.money_cap, center.ability.extra.money}} --#1# is replaced with card.ability.extra.Xmult
    end,
    
    calc_dollar_bonus = function(self,card)
        if G.GAME.dollars < card.ability.extra.money_cap then
            return card.ability.extra.money
        end
    end,
}
SMODS.Joker{
    key = 'pocketaces', --joker key
    loc_txt = { -- local text
        name = 'Pocket Aces',
        text = {
          'Destroy {C:attention}#2#{} cards to add',
          '{C:attention}2 Enhanced Aces{} to your',
          'hand when {C:attention}blind{} is selected',
          '{C:inactive}(Currently {C:attention}#1#{C:inactive}/#2#)'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 7, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        destructions = 0,
        required = 2
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.destructions, center.ability.extra.required}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.first_hand_drawn and card.ability.extra.destructions >= card.ability.extra.required then
            local cen_pool = {}
            for i=1, 2 do
                _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('pocket_aces_create'))
                for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                    if v.key ~= 'm_stone' then 
                        cen_pool[#cen_pool+1] = v
                    end
                end
                local new_card = create_playing_card({front = G.P_CARDS[_suit..'_'..'A'], center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))}, G.hand, nil, i ~= 1, {G.C.SECONDARY_SET.Spectral})
                playing_card_joker_effects({new_card})
                
            end
            card.ability.extra.destructions = 0
            G.hand:sort()
            return {
                message = 'Aces!',
                colour = G.C.MULT
            }
        end
        if context.remove_playing_cards then
            for k, val in ipairs(context.removed) do
                if card.ability.extra.destructions < card.ability.extra.required then
                    card.ability.extra.destructions = card.ability.extra.destructions + 1
                    if card.ability.extra.destructions == card.ability.extra.required then
                        local eval = function(card) return (card.ability.extra.destructions ~= 0) end
                        juice_card_until(card, eval, true)
                        return{
                            message = 'Active!',
                            card = card,
                            colour = G.C.MONEY
                        }
                    end
                end
            end
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'medusa', --joker key
    loc_txt = { -- local text
        name = 'Medusa',
        text = {
          'Converts all scored cards',
          'from {C:attention}first hand{} each',
          'round into {C:attention}Stone cards{}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 7, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 2, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and G.GAME.current_round.hands_played == 0 then
            for k, v in ipairs(context.scoring_hand) do
                v:set_ability(G.P_CENTERS.m_stone, nil, true)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:juice_up()
                        return true
                    end
                })) 
            end
            return {message = 'Stone', colour = G.C.PURPLE}
        end
    end,

    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'workoutroutine', --joker key
    loc_txt = { -- local text
        name = 'Workout Routine',
        text = {
          'cycles between reps',
          '1. {C:chips}+#1#{} chips',
          '2. {C:mult}+#2#{} mult',
          '3. {X:mult,C:white}X#3#{} mult',
          'each round {C:inactive}(Currently rep {C:attention}#4#{}{C:inactive})'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 3, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chips = 100,
        mult = 20,
        Xmult = 2,
        cycle = 1
      }
    },
    loc_vars = function(self, info_queue, center)
        local chips = center.ability.extra.chips
        local mult = center.ability.extra.mult
        local xmult = center.ability.extra.Xmult

        local cycle = center.ability.extra.cycle

        return {vars = {chips, mult, xmult, cycle}}
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
            elseif card.ability.extra.cycle == 2 then
                card.ability.extra.cycle = 3
            elseif card.ability.extra.cycle == 3 then
                card.ability.extra.cycle = 1
            end
            return {
                message = 'Shift',
                colour = G.C.MONEY
            }
        end
    end,
}
SMODS.Joker{
    key = 'middlefinger', --joker key
    loc_txt = { -- local text
        name = 'Middle Finger',
        text = {
          '{X:mult,C:white}X#1#{} Mult during',
          '{C:attention}boss blinds{}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 8, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 4, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 3 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.joker_main and G.GAME.blind.boss then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
    end,
}
SMODS.Joker{
    key = 'vengefulspirit', --joker key
    loc_txt = { -- local text
        name = 'Vengeful Spirit',
        text = {
          '{X:mult,C:white}X#2#{} mult per {C:spectral}spectral{}',
          'card used this run',
          '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive})'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 7, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 5, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
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
        return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_mod}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if G.GAME.consumeable_usage_total and not context.blueprint then
            card.ability.extra.Xmult = 1 + (G.GAME.consumeable_usage_total.spectral * card.ability.extra.Xmult_mod) 
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
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'scratchticket', --joker key
    loc_txt = { -- local text
        name = 'Scratch Ticket',
        text = {
          'Sell this card for',
          'a {C:green}#1# in #2#{} chance',
          'to win {C:money}$#3#{}',
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 2, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = true, --can it be perishable
    pixel_size = { w = 0.81 * 71, h = 0.78 * 95 },
    pos = {x = 6, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        odds = 15,
        money = 40
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {G.GAME.probabilities.normal, center.ability.extra.odds, center.ability.extra.money}} --#1# is replaced with card.ability.extra.Xmult
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
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'eventhorizon', --joker key
    loc_txt = { -- local text
        name = 'Event Horizon',
        text = {
          'Generates a {C:spectral}Black Hole{}',
          '{C:spectral}Spectral card{} if at least {C:attention}#2#{} unique',
          'hand types were played this round',
          '{C:inactive}Currently ({C:attention}#1#/#2#{C:inactive})'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 8, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 7, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        unique_hands = 0,
        required = 3
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.unique_hands, center.ability.extra.required}} --#1# is replaced with card.ability.extra.Xmult
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
        
        if context.end_of_round and not context.individual and not context.repetition then
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
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.PURPLE})                       
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
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'euchre', --joker key
    loc_txt = { -- local text
        name = 'Euchre',
        text = {
          'Each {C:attention}Jack{} held in',
          'hand at the end of',
          'the round earns {C:money}$#1#{}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 8, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        money = 2 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.money}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.hand and context.individual and context.end_of_round and context.other_card:get_id() == 11 then
            return {
                card = card,
                dollars = card.ability.extra.money
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'jackpot', --joker key
    loc_txt = { -- local text
        name = 'Jackpot',
        text = {
          'If played hand contains 3',
          'scoring {C:attention}7s{}, score {C:mult}+#2# mult{}',
          'and earn {C:money}$#1#{} at',
          'the end of the round'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 9, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        money = 20,
        mult = 20,
        jackpot = false
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.money, center.ability.extra.mult, center.ability.extra.jackpot}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.jokers and context.joker_main then
            local _sevens = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 7 then
                    _sevens = _sevens + 1
                end
            end

            if _sevens >= 3 then
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
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'dragonegg', --joker key
    loc_txt = { -- local text
        name = 'Dragon Egg',
        text = {
          'Will transform into a',
          'random {C:red}Rare{C:attention} Joker{}',
          'after {C:attention}#2# rounds',
          '{C:inactive}(Currently {C:attention}#1#{C:inactive}/#2#)'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        rounds = 0,
        required = 3
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.rounds, center.ability.extra.required}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.end_of_round and not context.individual and not context.repetition then
            if card.ability.extra.rounds < card.ability.extra.required then
                card.ability.extra.rounds = card.ability.extra.rounds + 1
                    if card.ability.extra.rounds >= card.ability.extra.required then
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
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                    local card = create_card('Joker', G.jokers, nil, 2, nil, nil, nil, 'dra')
                                    card:add_to_deck()
                                    G.jokers:emplace(card)
                                    card:start_materialize()
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
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'dynamite', --joker key
    loc_txt = { -- local text
        name = 'Dynamite',
        text = {
          'At the end of each round,',
          '{C:attention}destroy{} a random card held',
          'in hand and gain {C:mult}+#2#{} Mult',
          '{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 0,
        mult_mod = 4
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
            local destroyed_cards = {}
            destroyed_cards[#destroyed_cards+1] = pseudorandom_element(G.hand.cards, pseudoseed('random_destroy'))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
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
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'bubblewrap', --joker key
    loc_txt = { -- local text
        name = 'Bubble Wrap',
        text = {
          '{C:chips}+#1#{} Chips for each',
          '{C:attention}consumable{} in your',
          '{C:attention}consumable{} area',
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 4, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 2, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chip_mod = 60
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chip_mod}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.joker_main and G.consumeables.cards[1] then
            return {
                card = card,
                chip_mod = #G.consumeables.cards * card.ability.extra.chip_mod,
                message = '+' .. #G.consumeables.cards * card.ability.extra.chip_mod,
                colour = G.C.CHIPS
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'graffiti',
    loc_txt = {
        name = 'Graffiti',
        text = {
            'Sell this card after {C:attention}#2#{} round to add',
            '{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or {C:dark_edition}Polychrome{} edition',
            'to a random {C:attention}Joker',
            '{C:inactive}(Currently {C:attention}#1#{C:inactive}/#2#)'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
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
        return { vars = { center.ability.extra.rounds, center.ability.extra.required} }
    end,
    calculate = function(self, card, context)

        if context.end_of_round and not context.individual and not context.repetition then
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

        if context.selling_self and card.ability.extra.rounds >= card.ability.extra.required then
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
    key = 'threemusketeers', --joker key
    loc_txt = { -- local text
        name = 'Three Musketeers',
        text = {
          'Each scored {C:attention}3{} will',
          'earn between {C:money}$#1#{} and {C:money}$#2#{}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 4, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        min_money = 1,
        max_money = 3,
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.min_money, center.ability.extra.max_money}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 3 then
            local earned = math.random(card.ability.extra.min_money, card.ability.extra.max_money)
                return {
                    card = card,
                    dollars = earned,
                }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'corporatejoker', --joker key
    loc_txt = { -- local text
        name = 'Corporate Joker',
        text = {
          'This Joker gains {C:chips}+#4#{} Chips and {C:mult}+#2#{} Mult',
          'after {C:attention}Boss Blind{} is defeated,',
          'resets if any {C:attention}Blind{} is skipped',
          '{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips and {C:mult}+#1#{C:inactive} Mult)'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 4, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 5, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 0,
        mult_mod = 5,
        chips = 0,
        chips_mod = 25,
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod, center.ability.extra.chips, center.ability.extra.chips_mod }} --#1# is replaced with card.ability.extra.Xmult
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
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'boxofdonuts', --joker key
    loc_txt = { -- local text
        name = 'Box of Donuts',
        text = {
          'For the next {C:attention}#1#{} rounds,',
          'when {C:attention}Blind{} is selected',
          'create {C:attention}1 {C:green}Common{C:attention} Joker',
          '{C:inactive}(Must have room)',
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 6, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        remaining = 6,
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.remaining}} --#1# is replaced with card.ability.extra.Xmult
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
            if card.ability.extra.remaining > 0 and not context.blueprint then
                return{
                    card = card,
                    message = '-1',
                    colour = G.C.MONEY
                } 
            elseif not context.blueprint then
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
                return{
                    card = card,
                    message = 'eaten!',
                    colour = G.C.MONEY
                } 
            end
        end
        
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'amethyststaff', --joker key
    loc_txt = { -- local text
        name = 'Amethyst Staff',
        text = {
          'When a {C:purple}Purple Seal{}',
          'is discarded, generate',
          'an extra {C:tarot}Tarot{} card'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 7, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            if context.other_card.seal == 'Purple' then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            G.E_MANAGER:add_event(Event({
                                func = function() 
                                    local card = create_card('Tarot_Planet',G.consumeables, nil, nil, nil, nil, nil, 'amethyst')
                                    card:add_to_deck()
                                    G.consumeables:emplace(card)
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end}))                      
                            return true
                        end)}))
                    return {
                        card = card,
                        message = 'Abracadabra!',
                        colour = G.C.PURPLE 
                    }
                end
                
            end
        
        end
    end,

    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'hunter', --joker key
    loc_txt = { -- local text
        name = 'Hunter',
        text = {
          "When hand is played,",
          "discard the {C:attention}2 rightmost{}", 
          "cards held in hand"
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 8, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        shots = 2
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.shots}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self, card, context)
        if context.press_play then
            G.E_MANAGER:add_event(Event({ func = function()
                local any_selected = false
                local _cards = G.hand.cards

                for i = #_cards, math.max(#_cards - 1, 1), -1 do
                    local selected_card = _cards[i]
                    if selected_card then
                        G.hand:add_to_highlighted(selected_card, true)
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
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'wildwest', --joker key
    loc_txt = { -- local text
        name = 'Wild West',
        text = {
          "Provides {C:attention}+1{} extra hand size",
          "for every {C:attention}#2# Wild Cards{} in your", 
          "full deck at the end of the round", 
          "{C:inactive}(Currently {C:attention}+#1#{C:inactive})"
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 7, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 9, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        extra_hand_size = 0,
        per = 2,
        last_applied_size = 0
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.extra_hand_size, center.ability.extra.per}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition then
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
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'flawlessvictory', --joker key
    loc_txt = { -- local text
        name = 'Flawless Victory',
        text = {
          "Earn {C:money}$#2#{} per remaining",
          "hand if blind is", 
          "defeated in {C:attention}1{} hand"
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 3}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        money = 0,
        money_mod = 2,
        flawless = false
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.money, center.ability.extra.money_mod, center.ability.extra.flawless}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and G.GAME.current_round.hands_played <= 1 and not context.blueprint then
            card.ability.extra.flawless = true
            card.ability.extra.money = G.GAME.current_round.hands_left * card.ability.extra.money_mod
        end
    end,

    calc_dollar_bonus = function(self,card)
        if card.ability.extra.flawless then
            card.ability.extra.flawless = false
            return card.ability.extra.money
        end
    end,

    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'kidsdrawing', --joker key
    loc_txt = { -- local text
        name = 'Kids Drawing',
        text = {
          '{C:green}#1# in #2#{} chance to add',
          'a random {C:attention}enhancement{} to',
          'any scored cards'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 3}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        odds = 8
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {G.GAME.probabilities.normal, center.ability.extra.odds}} --#1# is replaced with card.ability.extra.Xmult
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
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'cruiseship', --joker key
    loc_txt = { -- local text
        name = 'Cruise Ship',
        text = {
          '{X:mult,C:white}X#2#{} mult for every',
          '{C:voucher}voucher{} owned',
          '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive})'

        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 7, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 2, y = 3}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 1,
        Xmult_mod = 0.4
      }
    },
    loc_vars = function(self,info_queue,center)
        local vouchers_redeemed = 0
        for k, v in pairs(G.GAME.used_vouchers) do
            vouchers_redeemed = vouchers_redeemed + 1
        end
        center.ability.extra.Xmult = 1 + (vouchers_redeemed * center.ability.extra.Xmult_mod)

        return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_mod}} --#1# is replaced with card.ability.extra.Xmult
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
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'protest', --joker key
    loc_txt = { -- local text
        name = 'Protest',
        text = {
          "Adds {C:attention}triple{} the rank",
          "of the {C:attention}#1# leftmost{} cards",
          "held in hand to Chips",
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 3, y = 3}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        num_of_cards = 3 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.num_of_cards}} --#1# is replaced with card.ability.extra.Xmult
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
                    colour = G.C.CHIPS
                }
            end
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'landlord', --joker key
    loc_txt = { -- local text
        name = 'Landlord',
        text = {
          'If hand conatins a',
          '{C:attention}Full House{} then',
          '{X:mult,C:white}X#1#{} Mult, lose {C:money}$#2#{}',
          'and add {C:money}$#2#{} to sell value'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 3.5,
        money = 1
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.money}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.before and context.poker_hands and next(context.poker_hands["Full House"]) and not context.blueprint then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.money
            card:set_cost()
            return {
                card = card,
                dollars = card.ability.extra.money * -1,
                message = 'Rent Due!',
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
        --whether or not this card is in the pool, return true if it is, return false if its not
        return false
    end,
}
SMODS.Joker{
    key = 'lockpick',
    loc_txt = {
        name = 'Lock Pick',
        text = {
          'Skipping any {C:attention}Blind{}',
          'generates {C:attention}#1#{} other',
          'random {C:attention}tags'
        },
    },
    atlas = 'Jokers',
    rarity = 2, 
    cost = 6,
    unlocked = false, 
    discovered = false, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 1, y = 0}, 
    config = { 
      extra = {
        tags = 2,
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.tags}} 
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
                                    available_handtypes[#available_hands + 1] = k
                                end
                            end

                            tag.ability.orbital_hand = pseudorandom_element(available_handtypes, pseudoseed('lock'))
                        end

                        add_tag(tag)
                        play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    end
                    return true
                end)
            }))
            return {
                card = card,
                message = 'Lock picked!',
                colour = G.C.GREEN
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return false
    end,
}
SMODS.Joker{
    key = 'squirel', --joker key
    loc_txt = { -- local text
        name = 'Squirrel',
        text = {
          '{C:chips}+#1#{} Chips. Sell this',
          'card during a {C:attention}blind{}',
          'to replace it with a',
          '{C:blue}Common{} Joker'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 3, --cost
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chips = 10,
        canBeSacrificed = false
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.setting_blind and not context.blueprint then
			card.ability.extra.canBeSacrificed = true
            local eval = function(card) return (card.ability.extra.canBeSacrificed == true) end
            juice_card_until(card, eval, true)
            return{
                message = 'Please...',
                card = card,
                colour = G.C.BLACK
            }
		end

		if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
			card.ability.extra.canBeSacrificed = false
            return{
                message = 'Thank you!',
                card = card,
                colour = G.C.BLACK
            }
		end

        if context.selling_self and card.ability.extra.canBeSacrificed and not context.blueprint then
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
        --whether or not this card is in the pool, return true if it is, return false if its not
        return false
    end,
}
SMODS.Joker{
    key = 'diamondarmor',
    loc_txt = {
        name = 'Diamond Armor',
        text = {
          'Score {C:diamonds}#2# Diamond{} cards {C:inactive}[#1#]{} to',
          'activate this joker and',
          'prevent death {C:attention}#3#{} times',
        },
    },
    atlas = 'Jokers',
    rarity = 3, 
    cost = 8,
    unlocked = false, 
    discovered = false, 
    blueprint_compat = false, 
    eternal_compat = false, 
    perishable_compat = true, 
    pos = {x = 1, y = 0}, 
    config = { 
      extra = {
        diamonds = 0,
        required = 20,
        lives = 2,
        active = false
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.diamonds, center.ability.extra.required, center.ability.extra.lives, center.ability.extra.active}} 
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Diamonds") and card.ability.extra.diamonds < card.ability.extra.required and not context.blueprint then
            card.ability.extra.diamonds = card.ability.extra.diamonds + 1 
            
        end

        if context.joker_main and card.ability.extra.diamonds >= card.ability.extra.required and card.ability.extra.active == false and not context.blueprint then
            card.ability.extra.active = true
            local eval = function(card) return (card.ability.extra.lives ~= 0) end
            juice_card_until(card, eval, true)
            return {
                message = 'Release!',
                colour = G.C.BLUE
            } 
        end 

        if context.end_of_round and not context.blueprint and context.game_over and card.ability.extra.diamonds >= card.ability.extra.required then
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
        return false
    end,
}
SMODS.Joker{
    key = 'climbthemountain',
    loc_txt = {
        name = 'Climb the Mountain',
        text = {
          'Each scored {C:attention}#4#{} gains {C:mult}+#2#{} Mult,',
          'rank increases every round',
          '{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)',
        },
    },
    atlas = 'Jokers',
    rarity = 1, 
    cost = 6,
    unlocked = false, 
    discovered = false, 
    blueprint_compat = false, 
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 1, y = 0}, 
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
                extra = {focus = card, message = localize('k_upgrade_ex')},
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
                colour = G.C.MONEY
            }
            
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return false
    end,
}
SMODS.Joker{
    key = 'blackrose', --joker key
    loc_txt = { -- local text
        name = 'Black Rose',
        text = {
          "Retrigger all",
          "played {C:spades}Spade{} cards",
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 4, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.play and context.repetition and context.other_card:is_suit("Spades") then
                return {
                    card = card,
                    repetitions = 1,
                    message = 'Again!', 
                    colour = G.C.BLACK
                }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return false
    end,
}
SMODS.Joker{
    key = 'angelanddevil', --joker key
    loc_txt = { -- local text
        name = 'Angel and Devil',
        text = {
          "When {C:attention}Blind{} is selected,",
          "gain {C:blue}+#1#{} Hand or",
          "gain {C:red}+#2#{} Discard",
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 4, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        extra_hands = 1,
        extra_discards = 1
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.extra_hands, center.ability.extra.extra_discards}} --#1# is replaced with card.ability.extra.Xmult
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
        --whether or not this card is in the pool, return true if it is, return false if its not
        return false
    end,
}
SMODS.Joker{
    key = 'snakeeyes', --joker key
    loc_txt = { -- local text
        name = 'Snake Eyes',
        text = {
          "Cuts all {C:attention}listed",
          "{C:green,E:1,S:1.1}probabilities{} in half.",
          "{C:green}#1# in #2#{} chance to add {C:chips}+#4#{}",
          "chips when hand is played",
          "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)"
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 3, --cost
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 4, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        odds = 9,
        chips = 0,
        chips_mod = 36
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {G.GAME.probabilities.normal, center.ability.extra.odds, center.ability.extra.chips, center.ability.extra.chips_mod }} --#1# is replaced with card.ability.extra.Xmult
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
        --whether or not this card is in the pool, return true if it is, return false if its not
        return false
    end,
}
SMODS.Joker{
    key = 'bruce', --joker key
    loc_txt = { -- local text
        name = 'Bruce',
        text = {
          "When {C:attention}Blind{} is selected,",
          "gain {X:mult,C:white} X#2# {} Mult and {C:attention}destroy{} a random",
          "{C:attention}consumable{}. If there are no consumables,",
          "{C:attention}destroy{} a random Joker instead",
          "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive})"
        },
    },
    atlas = 'Jokers', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 8, --cost
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 4, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 1,
        Xmult_mod = 0.25
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_mod}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if not context.blueprint and context.setting_blind then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod

            local consumable_to_destroy = pseudorandom_element(G.consumeables.cards, pseudoseed('bruce'))
            
            local destructable_jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not G.jokers.cards[i].ability.eternal and not G.jokers.cards[i].getting_sliced then destructable_jokers[#destructable_jokers+1] = G.jokers.cards[i] end
            end
            local joker_to_destroy = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('bruce')) or nil

            if consumable_to_destroy ~= nil then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.8, 0.8)
                        consumable_to_destroy:juice_up(0.3, 0.4)
                        consumable_to_destroy:start_dissolve()
                        return true
                    end
                }))
            end

            if joker_to_destroy and not consumable_to_destroy then 
                G.E_MANAGER:add_event(Event({func = function()
                    card:juice_up(0.8, 0.8)
                    joker_to_destroy:juice_up(0.3, 0.4)
                    joker_to_destroy:start_dissolve({G.C.RED}, nil, 1.6)
                return true end }))
            end
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}}})
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
        --whether or not this card is in the pool, return true if it is, return false if its not
        return false
    end,
}
SMODS.Joker{
    key = 'johnpolychrome', --joker key
    loc_txt = { -- local text
        name = 'John Polychrome',
        text = {
          'Adds {C:dark_edition}Polychrome{} edition',
          'to all scored cards'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 4, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 20, --cost
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 2, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers then
            for k, v in ipairs(context.scoring_hand) do
                v:set_edition('e_polychrome', true)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:juice_up()
                        return true
                    end
                })) 
            end
        end
    end,

    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return false
    end,
}
SMODS.Joker{
    key = 'johnfree', --joker key
    loc_txt = { -- local text
        name = 'John Free',
        text = {
          'All shop purchases except',
          '{C:attention}rerolls{} are free',
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 4, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 20, --cost
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 2, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self, card, context)
        if context.reroll_shop or context.starting_shop then
            G.E_MANAGER:add_event(Event({func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v.cost = 0 end
                end
            return true end }))
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            for k, v in pairs(G.I.CARD) do
                if v.set_cost then v.cost = 0 end
            end
        return true end }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            for k, v in pairs(G.I.CARD) do
                if v.set_cost then v:set_cost() end
            end
        return true end }))
    end,

    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return false
    end,
}
----------------------------------------------
------------MOD CODE END----------------------
    
