//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ToDoList{
    struct Todo{ 
        string task;
        bool completed;
    }

    Todo[] private todo_arr; //to block public access, access only with get function

    function create(string calldata _task) external{ //we can mark as memory or calldata but, calldata saves gas
        todo_arr.push(Todo({
            task: _task,
            completed: false
        }));
    }

    function updateTask(uint _index, string calldata _task) external{
        todo_arr[_index].task = _task; 
        //This way needs more gas when you want to reach indexes multiple times, but if you wnat to reach one time, does not matter much

        //Todo storage todo = todo_arr[_index];
        //todo.task = _task;
        //this way needs less gas when you want to reach indexes multiple times
    }

    function get(uint _index) external view returns(string memory, bool){
        Todo storage todo = todo_arr[_index]; //stroage saves gas
        return (todo.task, todo.completed);
    }

    function toggleCompleted(uint _index) external{
        todo_arr[_index].completed = !todo_arr[_index].completed; //reverse the bool
    }
}