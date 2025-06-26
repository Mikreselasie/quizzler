import 'dart:math';
// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';
import 'question.dart';

class QuestionBrain {
  int _questionNumber = 0;
  final List<Question> _allQuestions = [
    Question("The Earth revolves around the Sun.", true),
    Question("Water boils at 100 degrees Celsius.", true),
    Question("Humans have walked on the Moon.", true),
    Question("The Pacific Ocean is the largest ocean on Earth.", true),
    Question("Light travels faster than sound.", true),
    Question("Mount Everest is the tallest mountain on Earth.", true),
    Question("The human body has 206 bones.", true),
    Question("Oxygen is essential for human survival.", true),
    Question("The Great Wall of China is in China.", true),
    Question("Venus is a planet in the solar system.", true),
    Question("Sharks are fish, not mammals.", true),
    Question("Plants produce oxygen during photosynthesis.", true),
    Question("Bats are the only mammals capable of true flight.", true),
    Question("Octopuses have three hearts.", true),
    Question("The Amazon rainforest is the largest in the world.", true),
    Question("Penguins live in the Southern Hemisphere.", true),
    Question("A year has 365 days.", true),
    Question("The speed of light is about 300,000 km/s.", true),
    Question("Humans need water to survive.", true),
    Question("The Eiffel Tower is in Paris.", true),
    Question("A group of lions is called a pride.", true),
    Question("Whales are mammals.", true),
    Question("The boiling point of water is 100°C at sea level.", true),
    Question("The currency of Japan is the Yen.", true),
    Question("Cows are herbivores.", true),
    Question("Sound needs a medium to travel.", true),
    Question("The Great Wall of China is in China.", true),
    Question("The Eiffel Tower is located in France.", true),
    Question("Venus is the second planet from the Sun.", true),
    Question("Lightning is a discharge of electricity.", true),
    Question("An adult human has 32 teeth.", true),
    Question("The heart pumps blood through the body.", true),
    Question("Saturn has rings.", true),
    Question("Water covers about 70% of Earth’s surface.", true),
    Question("Polar bears live in the Arctic.", true),
    Question("Hummingbirds can fly backwards.", true),
    Question("The moon affects ocean tides.", true),
    Question("Trees absorb carbon dioxide.", true),
    Question("Snakes have no eyelids.", true),
    Question("Owls can rotate their heads nearly 270 degrees.", true),
    Question("Jellyfish have been around for millions of years.", true),
    Question("The human brain controls the nervous system.", true),
    Question("A blue whale is the largest animal on Earth.", true),
    Question("Mars is known as the Red Planet.", true),
    Question("Solar energy comes from the Sun.", true),
    Question("Spiders have eight legs.", true),
    Question("Earth is the third planet from the Sun.", true),
    Question("Penguins cannot fly.", true),
    Question("Water expands when it freezes.", true),
    Question("Most plant leaves are green due to chlorophyll.", true),
    Question("The Sun revolves around the Earth.", false),
    Question("Water freezes at 50 degrees Celsius.", false),
    Question("Humans can breathe underwater without equipment.", false),
    Question("The Atlantic Ocean is larger than the Pacific.", false),
    Question("Sound travels faster than light.", false),
    Question("Mount Kilimanjaro is taller than Mount Everest.", false),
    Question("The human body has 500 bones.", false),
    Question("Humans can live without oxygen.", false),
    Question("The Great Wall of China is in Japan.", false),
    Question("Pluto is the largest planet in the solar system.", false),
    Question("The moon is made of cheese.", false),
    Question("Bulls are enraged by the color red.", false),
    Question("Goldfish have a memory of only 3 seconds.", false),
    Question("Humans only use 10% of their brains.", false),
    Question("Lightning never strikes the same place twice.", false),
    Question("Bats are blind.", false),
    Question(
      "You can see the Great Wall of China from space with the naked eye.",
      false,
    ),
    Question(
      "Chameleons change color to blend into their surroundings.",
      false,
    ),
    Question("Eating carrots significantly improves night vision.", false),
    Question("A coin dropped from a skyscraper can kill someone.", false),
    Question("The Sahara is the largest desert in the world.", false),
    Question("Alcohol warms your body.", false),
    Question("Camels store water in their humps.", false),
    Question("Bananas grow on trees.", false),
    Question("All spiders are venomous to humans.", false),
    Question("Humans evolved directly from monkeys.", false),
    Question("Diamonds are made of glass.", false),
    Question("Birds are mammals.", false),
    Question("Lightning always comes from clouds to the ground.", false),
    Question("The internet is a physical place.", false),
    Question("Washing hands with hot water kills all germs.", false),
    Question("The sky is blue because of the ocean reflection.", false),
    Question("Humans can see ultraviolet light.", false),
    Question("Touching a frog gives you warts.", false),
    Question("Antarctica is a country.", false),
    Question("Elephants can jump.", false),
    Question("Bees die immediately after stinging any creature.", false),
    Question("A tomato is a vegetable.", false),
    Question("Humans have 4 hearts.", false),
    Question("Owls are blind during the day.", false),
    Question("Sharks are mammals.", false),
    Question("Penguins can fly.", false),
    Question("Ostriches can fly.", false),
    Question("Lightning is hotter than the sun.", false),
    Question("Humans have gills.", false),
    Question("Water is dry.", false),
    Question("Clouds are made of cotton.", false),
    Question("Fire is a liquid.", false),
    Question("Snakes have legs.", false),
  ];

  late List<Question> _selectedQuestions;

  void generateNewQuiz() {
    _allQuestions.shuffle(Random());
    _selectedQuestions = _allQuestions.take(10).toList();
  }

  QuestionBrain() {
    generateNewQuiz();
  }
  void nextQuestion() {
    if (_questionNumber < 10) {
      _questionNumber++;
    }
  }

  void reset() {
    _questionNumber = 0;
    generateNewQuiz();
  }

  String getQuestionText() {
    return _selectedQuestions[_questionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return _selectedQuestions[_questionNumber].questionAnswer;
  }

  int getQuestionNo() {
    return _questionNumber;
  }
}
