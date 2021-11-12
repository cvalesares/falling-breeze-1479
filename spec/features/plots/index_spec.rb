require 'rails_helper'

RSpec.describe 'Plots Index Page' do
  it 'has a list of all plot numbers' do
    garden1 = Garden.create!(name: "Tiny Garden", organic: true)
    plot1 = Plot.create!(number: 1, size: "Small", direction: "North", garden_id: garden1.id)
    plot2 = Plot.create!(number: 2, size: "Medium", direction: "South", garden_id: garden1.id)
    plant1 = plot1.plants.create!(name: "Rose", description: "Red", days_to_harvest: 13, plots_id: plot1.id)
    plant2 = plot1.plants.create!(name: "Lilly", description: "White", days_to_harvest: 12, plots_id: plot1.id)
    plant3 = plot2.plants.create!(name: "Watermelon", description: "Green", days_to_harvest: 32, plots_id: plot2.id)

    visit "/plots"
    
    expect(page).to have_content(plot1.number)
    expect(page).to have_content(plot2.number)
    expect(page).to have_content(plant1.name)
    expect(page).to have_content(plant2.name)
    expect(page).to have_content(plant3.name)

    within "#id-#{plot1.id}" do
      expect(page).to have_content(plant1.name)
      expect(page).to have_content(plant2.name)
    end
    within "#id-#{plot2.id}" do
      expect(page).to have_content(plant3.name)
    end
  end
end
# User Story 1, Plots Index Page
# As a visitor
# When I visit the plots index page ('/plots')
# I see a list of all plot numbers
# And under each plot number I see names of all that plot's plants
