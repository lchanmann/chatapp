App.chat = App.cable.subscriptions.create("ChatChannel", {
  received: function(data) {
    throw 'Not yet implemented';
  },

  send_message: function(data) {
    return this.perform('send_message', data);
  }
});
