// Example socket
initial begin
  chandle h;
	
  // Connect
  h = socket_open("localhost:1234");
  if(h == null) begin
    $error("[ERROR] can't open socket.");
    $stop();
  end 

  // Send / receive
  if(!socket_write(h, "Hello World !")) begin
    $display("[ERROR] can't socket_write.");
    $stop();
  end
  $display(socket_read(h));

  // Done
  socket_close(h);
end
