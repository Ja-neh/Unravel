extends Node

func match_need_to_goal(need : String) -> GOAPGoal:
	match need:
		"hunger" : return GOAPGoalEat.new()
		"rest" : return GOAPGoalSleep.new()
		"social" : return GOAPGoalSocial.new()
		"fun" : return GOAPGoalFun.new()
		"money" : return GOAPGoalWork.new()
		_: return GOAPGoalEat.new()
