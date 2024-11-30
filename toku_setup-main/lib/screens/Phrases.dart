import 'package:flutter/material.dart';
import 'package:toku/components/item.dart';
import 'package:toku/models/itemModel.dart';


class PhrasesPage extends StatelessWidget {
  PhrasesPage({Key? key}) : super(key: key);

final List<ItemModel> numbers = [
    ItemModel(
      
        JpName: 'kuro',
        enName: 'are you coming ?',
        sound: 'sounds/phrases/are_you_coming.wav'),
    ItemModel(
        JpName: 'cha',
        enName: 'dont forget to subscribe',
        sound: 'sounds/phrases/dont_forget_to_subscribe.wav'),
    ItemModel(
        JpName: 'kirrooo',
        enName: 'how are you feeling ',
        sound: 'sounds/phrases/how_are_you_feeling.wav'),
    ItemModel(
        JpName: 'hai',
        enName: 'I love anime',
        sound: 'sounds/phrases/i_love_anime.wav'),
    ItemModel(
        JpName: 'midori',
        enName: 'I love programming ',
        sound: 'sounds/phrases/i_love_programming.wav'),
    ItemModel(
        JpName: 'aka',
        enName: 'programming is easy',
        sound: 'sounds/phrases/programming_is_easy.wav'),
    ItemModel(
        JpName: 'what is your name',
        enName: 'what is your name',
        sound: 'sounds/phrases/what_is_your_name.wav'),
    ItemModel(
        JpName: 'kiiro',
        enName: 'where are you going ',
        sound: 'sounds/phrases/where_are_you_going.wav'),
    ItemModel(
        JpName: 'kiiro',
        enName: 'yes im coming ',
        sound: 'phrases/yes_im_coming.wav'),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colors'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: 9,
        itemBuilder: (context, num) {
          return PhrasesItem(number: numbers[num],color: Colors.blue,);
        },
      ),
    );
  }
}
