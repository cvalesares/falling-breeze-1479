require 'rails helper'

RSpec.describe 'Garden Show' do
  it 'can list unique plants with < 100 days to harvest' do
    garden1 = Garden.create!(name: "Tiny Garden", organic: true)
    plot1 = garden1.plots.create!(number: 1, size: "Small", direction: "North", garden_id: garden1.id)
    plot2 = garden1.plots.create!(number: 2, size: "Medium", direction: "South", garden_id: garden1.id)
    plant1 = plot1.plants.create!(name: "Rose", description: "Red", days_to_harvest: 13, plots_id: plot1.id)
    plant2 = plot1.plants.create!(name: "Lilly", description: "White", days_to_harvest: 12, plots_id: plot1.id)
    plant3 = plot2.plants.create!(name: "Watermelon", description: "Green", days_to_harvest: 32, plots_id: plot2.id)
    plant4 = plot2.plants.create!(name: "Cactus", description: "Green", days_to_harvest: 101, plots_id: plot2.id)

    visit "/gardens/#{garden1.id}"

    expect(page).to have_content(plant1.name)
    expect(page).to have_content(plant2.name)
    expect(page).to have_content(plant3.name)
    expect(page).to_not have_content(plant4.name)
  end
end

# ```
# User Story 3, Garden's Plants
# As a visitor
# When I visit an garden's show page
# Then I see a list of plants that are included in that garden's plots
# And I see that this list is unique (no duplicate plants)
# And I see that this list only includes plants that take less than 100 days to harvest
# ```
