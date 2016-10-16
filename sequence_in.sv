//import "DPI-C" context function longint unsigned readframe();

class sequence_in extends uvm_sequence #(packet_in);
    `uvm_object_utils(sequence_in)

    function new(string name="sequence_in");
        super.new(name);
    endfunction: new

    task body;
        packet_in tr;

        forever begin
            tr = packet_in::type_id::create("tr");
             start_item(tr);
            tr.message = "message from transaction!!!\n";
            finish_item(tr);
        end
    endtask: body
endclass: sequence_in

