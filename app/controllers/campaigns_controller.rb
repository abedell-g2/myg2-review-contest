class CampaignsController < ApplicationController
  SAMPLE_CAMPAIGNS = [
    { title: "Acme's First Campaign",    incentivized: true,  amount: "$10",  spent: "$1,000",  goal: "100 of 150", type: "Email Campaign",    landing_page: "Preview", status: "active",   action: "Edit" },
    { title: "Acme's Second Campaign",   incentivized: true,  amount: "$50",  spent: "$19,000", goal: "Unlimited",  type: "Email Campaign",    landing_page: "Preview", status: "active",   action: "Edit" },
    { title: "Acme's Third Campaign",    incentivized: false, amount: "–",    spent: "–",       goal: "Unlimited",  type: "Vendor Led",        landing_page: "Preview", status: "active",   action: "Edit" },
    { title: "Acme's Refresh Campaign",  incentivized: false, amount: "–",    spent: "–",       goal: "55 of 100",  type: "Refresh Campaign",  landing_page: nil,       status: "active",   action: "Settings" },
    { title: "Acme's In-app Campaign",   incentivized: true,  amount: "$25",  spent: "$2,000",  goal: "75 of 100",  type: "In-App Campaign",   landing_page: nil,       status: "active",   action: "Settings" },
    { title: "Acme's Legacy Campaign '24", incentivized: true, amount: "$20", spent: "$800",    goal: "Unlimited",  type: "Vendor Led",        landing_page: nil,       status: "inactive", action: "Checkout" },
    { title: "Acme's Legacy Campaign '23", incentivized: true, amount: "$10", spent: "$400",    goal: "50 of 50",   type: "Vendor Led",        landing_page: nil,       status: "inactive", action: "Checkout" }
  ].freeze

  STRATEGIES = [
    { key: "landing_page",     name: "Review Landing Page",        description: "Create a dedicated landing page to capture customer reviews.",                          recommended: true  },
    { key: "embedded",         name: "Embedded Reviews",           description: "Add our customizable review workflow within your software or website.",                  recommended: false },
    { key: "refresh",          name: "Review Refresh Campaign",    description: "Prompt previous reviewers to update their experience",                                   recommended: false },
    { key: "email",            name: "Email Campaign",             description: "Reach out to customers with a targeted email campaign",                                   recommended: false },
    { key: "quarterly_contest", name: "Quarterly Review Contest",  description: "Using custom UTM parameters, compare review generation across people or channels",      recommended: false },
    { key: "event",            name: "Event Reviews",              description: "Build a landing page specifically for in-person reviewers at events and tradeshows.",     recommended: false }
  ].freeze

  def index
    @campaigns = SAMPLE_CAMPAIGNS
  end

  def select_strategy
    @strategies = STRATEGIES
  end

  def step1
    @strategy = find_strategy(params[:strategy])
  end

  def step2
    @strategy = find_strategy(params[:strategy])
    @landing_page_name = params[:landing_page_name]
  end

  def step3
    @strategy = find_strategy(params[:strategy])
    @landing_page_name = params[:landing_page_name]
    @utm_params = params[:utm_params]&.reject(&:blank?) || []
  end

  def create_campaign
    redirect_to campaigns_path, notice: "Campaign created successfully!"
  end

  private

  def find_strategy(key)
    STRATEGIES.find { |s| s[:key] == key } || STRATEGIES.first
  end
end
