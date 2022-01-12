import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web/bloc/ready_list_bloc.dart';
import 'package:web/models/search_model.dart';
import 'package:web/ui/re_hex_form.dart';

class ReadyList extends StatefulWidget {
  final ValueNotifier<bool> start;
  ReadyList(this.start);
  @override
  _ReadyListState createState() => _ReadyListState();
}

class _ReadyListState extends State<ReadyList> {
  final ReadyListBloc bloc = ReadyListBloc();
  //final ReadyListBloc bloc = Get.find();
  final ValueNotifier<String> errorText = ValueNotifier(' ');
  @override
  void initState() {
    // TODO: implement initState
    bloc.getNotifier(errorText);
    bloc.fetchReadyList();
    widget.start.addListener(() {
      if(widget.start.value==true)
        bloc.startCustomGame();
      widget.start.value = false;
    }
      );
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    //bloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        searchPanel(),
        /*
        Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               searchPanel(),
                /*
                TextButton(
                    onPressed: () async {
                      _errorText.value = await bloc.startCustomGame();
                    },
                    child: Text('Начать игру')
                ),

                 */

                IconButton(
                    onPressed: (){
                      bloc.fetchReadyList();
                      _errorText.value = ' ';
                      },
                    icon: Icon(Icons.refresh),
                ),
              ],
            )
        ),

         */
        Container(
          height: 75,
          child: Center(
            child: Wrap(
              children: [
                ValueListenableBuilder(
                  valueListenable: errorText,
                  builder: (context, value, child) {
                    return Text(
                      value,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1,
                    );
                  }
                ),
              ],
            ),
          )
        ),
        Expanded(
          flex: 8,
          child: Container(
          //  color: Colors.green,
            child: StreamBuilder<SearchResult>(
              stream: bloc.search,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return Container(
                  //  color: Colors.red,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 25,
                        mainAxisExtent: 50
                      ),
                      itemCount: snapshot.data.users.length,
                        itemBuilder: (BuildContext context, int index){
                        return playerTile(snapshot.data.users[index]);
                        }

                    ),
                  );
                  /*
                    ListView.builder(
                      itemCount: snapshot.data.users.length,
                      itemBuilder: (context, index) {
                        return tileItem(snapshot.data.users[index]);
                      }
                  );


                   */
                }

                else{
                  return Center(
                    child: Text('В данный момент нет игроков онлайн'),
                  );
                }
              }
            ),
          ),
        ),
      ],
    );
  }
  /*
  Widget tileItem(FoundUser user){
    return playerGrid();
    /*
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Text(user.name),
        playerTile(user.name),
        selectButton(user),
      ],
    );

     */
  }

   */
  Widget selectButton(FoundUser user){
   // final ValueNotifier<bool> _isSelected = ValueNotifier<bool>(false);
      return Obx(()=>IconButton(
          icon: Icon(
            // value.getList.containsKey(user.id)? Icons.check : Icons.add,
           bloc.getList.containsKey(user.id)&&bloc.getList[user.id]? Icons.check : Icons.add,
            // value.getList.containsKey(user.id)&&value.getList[user.id]? Icons.check : Icons.add,
            color: Colors.white,
            size: 15,),
          onPressed: () {
            //_isSelected.value = !_isSelected.value;
            bloc.addToCustomGameList(user);
          }
      ));
    return GetBuilder<ReadyListBloc>(
      id: user.id,
        builder: (value) => IconButton(
            icon: Icon(
             // value.getList.containsKey(user.id)? Icons.check : Icons.add,
              Icons.add,
            // value.getList.containsKey(user.id)&&value.getList[user.id]? Icons.check : Icons.add,
              color: Colors.white,
              size: 15,),
            onPressed: () {
              //_isSelected.value = !_isSelected.value;
              bloc.addToCustomGameList(user);
            }
        )
    );
/*
    return ValueListenableBuilder(
      valueListenable: _isSelected,
      builder: (context, value, child) {
        if(value)
          {
            return IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 15,),
                onPressed: () {
                  _isSelected.value = !_isSelected.value;
                  bloc.addToCustomGameList(user);
                }
            );
          }
        else {
          return IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 15,),
              onPressed: () {
                _isSelected.value = !_isSelected.value;
                bloc.addToCustomGameList(user);
              }
          );
        }
      }

 */
        /*
        return InkWell(
          onTap: (){
            _isSelected.value = !_isSelected.value;
            bloc.addToCustomGameList(user);
          },
          child: _isSelected.value?
          ReHexForm(
            Container(
              color: Theme
                  .of(context)
                  .cardColor,
              width: 50,
              height: 50,
              child: Container(
                padding: EdgeInsets.all(6.0),
                child: ReHexForm(
                  Container(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    child: ReHexForm(
                      Icon(
                        Icons.check, color: Colors.white, size: 25,),
                    ),
                  ),
                ),
              ),
            ),
          )
          :
        ReHexForm(
        Container(
        color: Color.fromARGB(250, 235, 208, 227),
        width: 50,
        height: 50,
        child: Container(
        padding: EdgeInsets.all(6.0),
        child: ReHexForm(
        Container(
        // color: Color.fromARGB(125, 235, 208, 227),
        color: Colors.white,
        child: ReHexForm(
        Icon(
        Icons.check, color: Color.fromARGB(250, 235, 208, 227), size: 25,),
        ),
        ),
        ),
        ),
        ),
        ),
        );
      }

         */

    //);
  }
  Widget playerTile(FoundUser user){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            selectButton(user),
            Text(
              user.name,
              style: Theme.of(context).textTheme.bodyText1,
              overflow: TextOverflow.clip,
            ),
          ],
        ),
        Text(
          'готов к игре',
          style: Theme.of(context).textTheme.headline3,
          overflow: TextOverflow.clip,
        ),
      ],
    );
  }
  /*
  Widget rowOfPlayers(){
    return Container(
      color: Colors.red,
      constraints: BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          playerTile('name'),
          playerTile('name'),
          playerTile('name'),
        ],
      ),
    );
  }

   */
  /*
  Widget playerGrid(){
    return GridView.count(
      crossAxisSpacing: 25,
        crossAxisCount: 3,
        children: [
          playerTile('name name name'),
          playerTile('name'),
          playerTile('name'),
          playerTile('name'),
          playerTile('name'),
          playerTile('name'),
        ],
    );
  }

   */
  Widget searchPanel(){
    return Container(
     // color: Colors.blue,
      padding: EdgeInsets.symmetric(horizontal: 50),
      height: 50,
      child: Row(
        children: [
/*
          Expanded(
            flex: 80,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.white)
                )
              ),
              onChanged: (value){},
            ),
          ),

 */
          Expanded(
            flex: 60,
            child: TextField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.white,)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.white)
                  )
              ),
              style: Theme.of(context).textTheme.bodyText1,
              cursorColor: Colors.white,
              onChanged: (value){bloc.changeInput(value);},
              onSubmitted: (value){bloc.addPlayerViaSearch(value);},
            ),
          ),
          Expanded(
            flex: 30,
            child: TextButton(
                onPressed: (){bloc.addPlayerViaSearchButton();},
                child: Text(
                  'добавить участника в игру',
                  style: Theme.of(context).textTheme.bodyText1,
                )
            ),
          ),
          Expanded(
            flex: 10,
            child: IconButton(
              onPressed: (){
                bloc.fetchReadyList();
                errorText.value = ' ';
              },
              icon: Icon(Icons.refresh, color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}
