# frozen_string_literal: true

seller = User.create!(name: 'Seller', role: 0)
realtor = User.create!(name: 'Realtor', role: 1)

Nps.create!(score: 5, touchpoint: 0, respondent_class: 'seller', respondent_id: seller.id,
            object_class: 'realtor', object_id: realtor.id)
Nps.create!(score: 0, touchpoint: 1, respondent_class: 'seller', respondent_id: seller.id,
            object_class: 'realtor', object_id: realtor.id)
Nps.create!(score: 7, touchpoint: 2, respondent_class: 'seller', respondent_id: seller.id,
            object_class: 'realtor', object_id: realtor.id)
Nps.create!(score: 10, touchpoint: 0, respondent_class: 'seller', respondent_id: seller.id,
            object_class: 'realtor', object_id: realtor.id)
