// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/constants/colors.dart';


class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn= true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', '',];
  String resultDeclaration = '';
   
 

  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0; //contar quantas caixas foram usadas no ganhador
  bool winnerFound = false; 

  static const maxSeconds = 30; 
  int seconds = maxSeconds;
  Timer? timer;


  static var customFontWhite = GoogleFonts.coiny(
    textStyle: TextStyle(
      color: Colors.white,
      letterSpacing: 5,
      fontSize: 28,
    ),
  );

  void starTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
       if( seconds > 0) { 
        seconds--;
       } else{
        stopTimer();
       }
      });
     }
     );
  }

  void stopTimer(){
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() => seconds = maxSeconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: MainColor.primaryColor,
      body:Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Jogador O', style: customFontWhite,),
                      Text(oScore.toString(), style: customFontWhite,),
                      
                    ],
                  ),
                  SizedBox(width: 30,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Jogador X',
                      style: customFontWhite,),
                      Text(xScore.toString(), style: customFontWhite,),
                      
                    ],
                  ),
                ],
              ),
               ),
      
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount (crossAxisCount: 3), 

               itemBuilder: (BuildContext context, int index) {
                 return GestureDetector(

                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 5,
                        color: MainColor.primaryColor
                      ),
                      color: MainColor.secondaryColor
                     
                    ),
                    child: Center(
                      child: Text(displayXO[index], 
                      style: GoogleFonts.coiny(
                        textStyle:
                          TextStyle( 
                          fontSize: 64,
                          color: MainColor.primaryColor
                           ),
                          ),
                          ),
                    ) ,
                  ),
                 );
               }
               ),
                ),
      
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      resultDeclaration, style: customFontWhite,
                      
                      ),
                      SizedBox(height: 10,),

                  _buildTimer()
                  ],
                )
                ),
                ),
          ],
        ),
      ),
    );
  }
  
  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    
    if(isRunning) {
       setState(() {
      if (oTurn && displayXO[index] == '') {
        displayXO[index] = 'O';
        filledBoxes++; 
      } else if(!oTurn && displayXO[index] == ''){
        displayXO[index] = 'X';
        filledBoxes++;
      }

      oTurn = !oTurn;
      _chekWinner();
    });
    }
   
  }

  void _chekWinner() {

    //primeira linha; começa com 0 para ser o primeiro bloco da primeira linha 
    if (displayXO[0] ==displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
          setState(() {
            resultDeclaration = 'jogador' + displayXO[0] + 'ganhou' ;
             _updateScore(displayXO[0]);
          });
        }

          //segunda linha; ficou 3 por ser da linha de baixo
    if (displayXO[3] ==displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
          setState(() {
            resultDeclaration = 'jogador' + displayXO[3] + 'ganhou' ;
             _updateScore(displayXO[3]);
          });
        }

          //segunda linha; 
         if (displayXO[6] ==displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
          setState(() {
            resultDeclaration = 'jogador' + displayXO[6] + 'ganhou' ;
             _updateScore(displayXO[6]);
          });
        }

        //primeira COLUNA; 3 e 6 por ser as casas com coluna
         if (displayXO[0] ==displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
          setState(() {
            resultDeclaration = 'jogador' + displayXO[0] + 'ganhou' ;
             _updateScore(displayXO[0]);
          });
        }

        //segunda COlUNA
         if (displayXO[1] ==displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
          setState(() {
            resultDeclaration = 'jogador' + displayXO[1] + 'ganhou' ;
             _updateScore(displayXO[1]);
          });
        }
        
        //terceira COLUNA
         if (displayXO[2] ==displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
          setState(() {
            resultDeclaration = 'jogador' +displayXO[2]+ 'ganhou' ;
             _updateScore(displayXO[2]);
          });
        }

        //diagonal da esquerda pra direita
         if (displayXO[0] ==displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
          setState(() {
            resultDeclaration = 'jogador' + displayXO[0] + 'ganhou' ;
            _updateScore(displayXO[0]);
          });
        }

        //diagonal da direita pra esquerda
         if (displayXO[6] ==displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
          setState(() {
            resultDeclaration = 'jogador' + displayXO[6] + 'ganhou'; 
              _updateScore(displayXO[6]);
          });
        }
       
        if( !winnerFound &&filledBoxes == 9) {
          setState(() {
            resultDeclaration = 'Empate';
          });
        }
  }

   void _updateScore(String winner){
          if (winner == 'O') {
            oScore++;
          }
          else if(winner == 'X') {
            xScore++; 
          }
          winnerFound= true; 
        } 

        void _clearBoard() {
          setState(() {
            for ( int i = 0; i < 9; i++) {
              displayXO[i] = '';
            }
            resultDeclaration = '';
          }
          );
          filledBoxes = 0;
        }
        Widget _buildTimer() {
          final isRunning = timer == null ? false : timer!.isActive;

        return isRunning 
        ? SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: 1 - seconds /maxSeconds,
                valueColor: AlwaysStoppedAnimation(Colors.white),
                strokeWidth: 8,
                backgroundColor: MainColor.accentColor,
              ),
              Center(
                child: Text(
                  '$seconds', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    color: Colors.white,
                    fontSize: 50,
                    ),
                    ),
              ),
            ],
          )
        )
         : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16 )
                          ),
                          onPressed: () {
                            starTimer();
                            _clearBoard();
                          },
                          child: Text('Jogue outra vez', 
                          style: TextStyle(fontSize: 20, color: Colors.black) ,),
                          );
        }
}