require 'rails_helper'

RSpec.describe 'Plots Index Page' do

  before :each do
    @garden1 = Garden.create!(name: "Tiny Garden", organic: true)
    @plot1 = Plot.create!(number: 1, size: "Small", direction: "North", garden_id: @garden1.id)
    @plot2 = Plot.create!(number: 2, size: "Medium", direction: "South", garden_id: @garden1.id)
    @plant1 = @plot1.plants.create!(name: "Rose", description: "Red", days_to_harvest: 13, plots_id: @plot1.id)
    @plant2 = @plot1.plants.create!(name: "Lilly", description: "White", days_to_harvest: 12, plots_id: @plot1.id)
    @plant3 = @plot2.plants.create!(name: "Watermelon", description: "Green", days_to_harvest: 32, plots_id: @plot2.id)
  end
  it 'has a list of all plot numbers' do

    visit "/plots"

    expect(page).to have_content(@plot1.number)
    expect(page).to have_content(@plot2.number)
    expect(page).to have_content(@plant1.name)
    expect(page).to have_content(@plant2.name)
    expect(page).to have_content(@plant3.name)

    within "#id-#{@plot1.id}" do
      expect(page).to have_content(@plant1.name)
      expect(page).to have_content(@plant2.name)
    end
    within "#id-#{@plot2.id}" do
      expect(page).to have_content(@plant3.name)
    end
  end

  it 'can remove a plant from the index page' do
    visit "/plots"
    save_and_open_page
    click_link "Remove #{@plant1.name}"
    expect(current_path).to eq("/plots")
    expect(page).to_not have_content(@plant1.name)
  end
end

# User Story 2, Remove a Plant from a Plot
# As a visitor
# When I visit a plot's index page
# Next to each plant's name
# I see a link to remove that plant from that plot
# When I click on that link
# I'm returned to the plots index page
# And I no longer see that plant listed under that plot
# (Note: you should not destroy the plant record entirely)
