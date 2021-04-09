
checkInputCell(input_cell,selected_index){
  bool does_contain = false;
  input_cell.forEach((cell){
    if(cell.contains(selected_index)){
      does_contain =  true;
    }
  });
  return does_contain;
}

moveRightCondition(index,input_cell){
  int selected_index = index;
  selected_index += 1;
  while(true){
    if(checkInputCell(input_cell,selected_index)){
      break;
    }
    else{
      selected_index += 1;
    }
  }
  return selected_index;
}

moveLeftCondition(index,input_cell){
  int selected_index = index;
  selected_index -= 1;
  while(true){
    if(checkInputCell(input_cell,selected_index)){
      break;
    }
    else{
      selected_index -= 1;
    }
  }
  return selected_index;
}


moveDown(index,last_index,current_grid_size){
  int temp = index + current_grid_size;
  if(temp > last_index){
    if ((temp - current_grid_size) == last_index){
      return 1;
    }else{
      print("index: " + index.toString());
      print("last_index: " + last_index.toString());
      print("current_grid_size: " + current_grid_size.toString());
      print("((index-last_index) + current_grid_size) + 1 : " + (((index - last_index) + current_grid_size) + 1).toString() );
      return ((index - last_index) + current_grid_size) + 1;
    }
  }
  else{
    return temp;
  }
}

moveUp(index,last_index,current_grid_size){
  int temp = index - current_grid_size;
  if (temp < 1){
    if ((temp + current_grid_size) == 1){
      return last_index;
    }
  }
  else{
    return temp;
  }
}

moveUpCondition(index,input_cell,last_index,current_grid_size){
  int selected_index = index;
  selected_index = moveUp(index,last_index,current_grid_size);
  while(true){
    if(checkInputCell(input_cell,selected_index)){
      break;
    }else{
    selected_index = moveUp(selected_index,last_index,current_grid_size);
    }
  }
  return selected_index;
}




moveDownCondition(index,input_cell,last_index,current_grid_size){
  int selected_index = index;
  selected_index = moveDown(index,last_index,current_grid_size);
  while(true){
    if(checkInputCell(input_cell,selected_index)){
      break;
    }else{
    selected_index = moveDown(selected_index,last_index,current_grid_size);
    }
  }
  return selected_index;
}


