`timescale 1ns/1ps

module serial_frame16 #(parameter HALF_CYCLES=25)(
    input wire clk_50mhz,rst_p,start,
    input wire [15:0] tx_word,
    input wire miso,
    output reg sclk,cs_n,mosi,busy,done,
    output reg [15:0] rx_word
);
    reg [31:0] count;
    reg [4:0] bit_index;
    reg [15:0] tx_latched;
    reg [2:0] quiet_count;

    always @(posedge clk_50mhz) begin
        if(rst_p) begin
            sclk<=1; cs_n<=1; mosi<=0; busy<=0; done<=0;
            count<=0; bit_index<=15; tx_latched<=0; rx_word<=0;
            quiet_count<=0;
        end
        else begin
            done<=0;

            if(!busy) begin
                if(quiet_count != 0)
                    quiet_count<=quiet_count-1'b1;
                else if(start) begin
                    cs_n<=0; busy<=1; count<=0; bit_index<=15;
                    tx_latched<=tx_word;
                    rx_word<=0;
                    mosi<=tx_word[15];
                end
            end
            else if(count==HALF_CYCLES-1) begin
                count<=0;

                if(sclk) begin
                    // SCLK를 내리기 직전의 ADC 출력 비트를 저장
                    rx_word<={rx_word[14:0],miso};
                    sclk<=0;
                end
                else begin
                    sclk<=1;

                    if(bit_index==0) begin
                        busy<=0; cs_n<=1; done<=1;
                        quiet_count<=4;
                    end
                    else begin
                        bit_index<=bit_index-1'b1;
                        // 다음 SCLK 하강 전에 송신 비트를 준비
                        mosi<=tx_latched[bit_index-1'b1];
                    end
                end
            end
            else
                count<=count+1;
        end
    end
endmodule