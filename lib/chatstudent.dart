class Chat{
  final String name, lastMessage, image, time;
  final bool isActive;

  Chat({
    this.name,
    this.lastMessage,
    this.image,
    this.time,
    this.isActive,
  });
}

List chatsData = [
  Chat(
    name: "Dr.Ashraf",
    lastMessage: "Hope you are doing well...",
    image: "assets/images/ASLOGO.png",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "Dr.Mohamed Hashem",
    lastMessage: "Hello Abdullah! I am...",
    image: "assets/images/ASLOGO.png",
    time: "8m ago",
    isActive: true,
  ),
  Chat(
    name: "Dr.Hatem",
    lastMessage: "Do you have update...",
    image: "assets/images/ASLOGO.png",
    time: "5d ago",
    isActive: false,
  ),
  Chat(
    name: "Docto1",
    lastMessage: "You’re welcome :)",
    image: "assets/images/ASLOGO.png",
    time: "5d ago",
    isActive: true,
  ),
  Chat(
    name: "Doctor2",
    lastMessage: "Thanks",
    image: "assets/images/ASLOGO.png",
    time: "6d ago",
    isActive: false,
  ),
  Chat(
    name: "Doctor3",
    lastMessage: "Hope you are doing well...",
    image: "assets/images/ASLOGO.png",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "Doctor4",
    lastMessage: "Hello Abdullah! I am...",
    image: "assets/images/ASLOGO.png",
    time: "8m ago",
    isActive: true,
  ),

];