import 'package:flutter/material.dart';

class HelpUi extends StatefulWidget {
  //final GameBloc gameBloc;
  //final Function hideHelp;
  //HelpUi(this.gameBloc, this.hideHelp);
  @override
  _HelpUiState createState() => _HelpUiState();
}

class _HelpUiState extends State<HelpUi> {
  final ScrollController helpScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 600.0,
        width: 500.0,
        color: Theme.of(context).hintColor,
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          controller: helpScrollController,
          isAlwaysShown: true,
          child: SingleChildScrollView(
            controller: helpScrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    'Экран разделен на 3 блока: индикаторы, игровое поле, панель выбора',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Container(
                  height: 5.0,
                ),
                Flexible(
                  child: Text(
                    'Индикаторы отображают текущий статус игры: сколько Звезд и Крестиков собрала каждая команда, чей сейчас ход и сколько времени на него осталось',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Container(
                  height: 5.0,
                ),
                Flexible(
                  child: Text(
                    'Слева от игрового поля показывается информация: номер Вашей команды и Ваша роль',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Container(
                  height: 5.0,
                ),
                Flexible(
                  child: Text(
                    'Слева и справа от игрового поля отображаются карточки, которые выбрали Навигаторы для своей команды',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Container(
                  height: 5.0,
                ),
                Flexible(
                  child: Text(
                    'На любую карточку можно нажать, чтобы рассмотреть ее крупнее. Карточки игрового поля, также, содержат дополнительную информацию',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Container(
                  height: 5.0,
                ),
                Flexible(
                  child: Text(
                    'Текущее положение команд показывается маркерами с соответствующей цифрой на игровом поле',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Container(
                  height: 5.0,
                ),
                Flexible(
                  child: Text(
                    'Панель выбора у Навигаторов и Разведчиков отличается: только у Навигатора есть схема с расположением Звезд и Крестиков',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Container(
                  height: 5.0,
                ),
                Flexible(
                  child: Text(
                    'В свой ход игрок выбирает карточку(и) и подтверждает свой выбор. До конца хода игрок может изменить свой выбор и отправить подтверждение повторно',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Container(
                  height: 5.0,
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                    onPressed: onBack,
                    child: Text('скрыть', style: Theme.of(context).textTheme.bodyText1,),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void onBack(){
    Navigator.pop(context);
    //widget.hideHelp();
  }
}
