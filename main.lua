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
          '{X:mult,C:white}X#1#{} Mult if',
          'hand is played',
          'while in debt or at {C:money}$0{}'
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
        Xmult = 3 --configurable value
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
          'create 2 free',
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
          '{C:mult}+#2#{} mult per hand',
          'size (currently {C:mult}+#1#{})'
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
        return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        card.ability.extra.mult = G.hand.config.card_limit * card.ability.extra.mult_mod
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
          '{C:tarot}#1#{} hands played'
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
          "Converts the next {C:attention}#1#{}",
          "scored cards into {C:spades}Spades{}"
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
          'generate a {C:tarot}Tarot{} card or {C:planet}Planet{}', 
          'card. {C:green}#1# in #2#{} chance to also',
          'create a {C:spectral}spectral{} card {C:inactive}(Must have room)'
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
          'If money is under {C:money}$#1#{}',
          'when round ends, earn {C:money}$#2#{}'
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
          'When 1 hand remains,',
          'add {C:attention}2{} random {C:attention}Enhanced',
          '{C:attention}Aces{} to your hand'
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
    pos = {x = 1, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        stop = false
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.stop}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if G.GAME.current_round.hands_left == 1 and not card.ability.extra.stop then
            local cen_pool = {}
            for i=1, 2 do
                _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('grim_create'))
                for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                    if v.key ~= 'm_stone' then 
                        cen_pool[#cen_pool+1] = v
                    end
                end
                create_playing_card({front = G.P_CARDS[_suit..'_'..'A'], center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))}, G.hand, nil, i ~= 1, {G.C.SECONDARY_SET.Spectral})
            end
            card.ability.extra.stop = true
            return {
                message = 'Aces!',
                colour = G.C.MULT
            }
        end
        if context.end_of_round and not context.individual and not context.repetition then
            card.ability.extra.stop = false
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
          'from {C:attention}first hand{}',
          'each round into {C:attention}Stone cards{}'
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
          'each round {C:inactive}(Currently rep {C:attention}#4#{}{C:inactive}))'
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
          '{X:mult,C:white}X#2#{} mult per {C:spectral}spectral{} card',
          'used this run {C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive})'
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
          'Generates a {C:spectral}black hole{}',
          '{C:spectral}spectral card{} if at least {C:attention}#2#{} unique',
          'hand types were played this round',
          '{C:inactive}({C:attention}#1#/#2#{C:inactive})'
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
          'scoring {C:attention}7s{}, score',
          '{C:mult}+#2# mult{} and earn {C:money}$#1#',
          'at the end of the round'
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
          'Will transform into a random',
          '{C:red}Rare{C:attention} Joker{} after {C:attention}#2# rounds',
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
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
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
        return false
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
    cost = 5, --cost
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
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
        if context.end_of_round and not context.individual and not context.blueprint and not context.repetition then
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
        return false
    end,
}
SMODS.Joker{
    key = 'bubblewrap', --joker key
    loc_txt = { -- local text
        name = 'Bubble Wrap',
        text = {
          '{C:chips}+#1#{} Chips for',
          'each {C:attention}consumable{} in your',
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
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 3, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chip_mod = 45
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
        return false
    end,
}
SMODS.Joker{
    key = 'spraypaint',
    loc_txt = {
        name = 'Spray Paint',
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
    unlocked = false,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    pos = {x = 2, y = 0},
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
        return false
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
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
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
        return false
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
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 6, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 0,
        mult_mod = 10,
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
        return false
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
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        remaining = 3,
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
        return false
    end,
}
SMODS.Joker{
    key = 'purplejoker', --joker key
    loc_txt = { -- local text
        name = 'Purple Joker',
        text = {
          'This Joker gains {C:chips}+#2#{} Chips',
          'when discarding a purple seal',
          '{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 6, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chips = 0,
        chips_mod = 12
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips, center.ability.extra.chips_mod}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            if context.other_card.seal == 'Purple' then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
                return {
                    card = card,
                    message = 'Upgrade',
                    colour = G.C.CHIPS
                }
            end
        elseif context.joker_main and card.ability.extra.chips > 0 then
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
    key = 'shotgun', --joker key
    loc_txt = { -- local text
        name = 'Shotgun',
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
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 8, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
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
        return false
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
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 8, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
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

    remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.extra_hand_size)
	end,


    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return false
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
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 8, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
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
        return false
    end,
}
SMODS.Joker{
    key = 'frozenjoker', --joker key
    loc_txt = { -- local text
        name = 'Frozen Joker',
        text = {
          "Adds a {C:blue}Blue Seal{}",
          "to scored {C:attention}face{} Cards"
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = false, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 8, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers then
            local frozen = false
            for k, v in ipairs(context.scoring_hand) do
                if v:is_face() then
                    frozen = true
                    v:set_seal('Blue', nil, true)
                end 
            end
            if frozen then
                return{
                    message = 'Frozen!',
                    colour = G.C.CHIPS
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
    pos = {x = 5, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
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
        return false
    end,
}
----------------------------------------------
------------MOD CODE END----------------------
    
