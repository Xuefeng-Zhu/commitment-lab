require 'minitest/autorun'
require 'yaml'

ROOT = File.expand_path('..', __dir__)
TEMPLATE = YAML.safe_load_file(File.join(ROOT, 'commitment-lab.template.yaml'))

class TemplateTest < Minitest::Test
  def test_room_connects_both_agents_and_creator
    assert_equal 1, TEMPLATE.fetch('version')
    agents = TEMPLATE.fetch('agents')
    assert_equal ['{team}-stakeholder', '{team}-coach'], agents.map { |agent| agent.fetch('name') }
    assert_equal agents.map { |agent| agent.fetch('name') }, TEMPLATE.fetch('room').fetch('agents')
    assert_equal ['{$creator}'], TEMPLATE.fetch('room').fetch('users')
    assert_equal 'channel_private', TEMPLATE.fetch('room').fetch('channel_type')
    assert_equal 'private', TEMPLATE.fetch('room').fetch('read_visibility')
    assert_equal 'private', TEMPLATE.fetch('room').fetch('write_visibility')
    agents.each do |agent|
      assert_equal 'anyone', agent.fetch('addressing')
      %w[provider location directory instructions].each { |key| refute_empty agent.fetch(key) }
      assert_equal '{directory}/{agent}', agent.fetch('directory')
    end
    assert_equal '{$agents_dir}', TEMPLATE.fetch('params').fetch('directory').fetch('default')
  end

  def test_scenario_and_coach_instructions_are_embedded
    agents = TEMPLATE.fetch('agents')
    stakeholder, coach = agents.map { |agent| agent.fetch('instructions') }
    assert_includes stakeholder, 'human mentor'
    assert_includes stakeholder, 'customer has not confirmed'
    assert_includes stakeholder, 'read_context'
    assert_includes coach, 'messages actually present'
    assert_includes coach, 'read_context'
    assert_includes coach, 'not stated'
  end

  def test_kickoff_starts_only_the_stakeholder
    kickoff = TEMPLATE.fetch('kickoff')
    assert_includes kickoff, '@{team}-stakeholder'
    refute_includes kickoff, '@{team}-coach'
  end
end
