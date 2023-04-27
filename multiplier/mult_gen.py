#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# +FHDR----------------------------------------------------------------------------
#                 Copyright (c) 2022 
#                       ALL RIGHTS RESERVED
# ---------------------------------------------------------------------------------
# Filename      : ap_com_gen.py
# Author        : Zeyang peng
# Created On    : 2022-11-16 23:34
# Last Modified : 2023-04-27 22:58
# ---------------------------------------------------------------------------------
# Description   : 
#
#
# -FHDR----------------------------------------------------------------------------
import os 
import re
import argparse
import csv
import shutil

def dec2bin(arg, wid):
    """
        This function change unsigned decimal number to unsigned binary number with wraping overflow.
        arg: decimal number
        wid: bit width
        returns: binary number
    """
    if wid <= 0:
        return ""
    elif arg>=2**wid:
        arg_wrap = arg & (2**wid-1) 
        return f"{arg_wrap:0{wid}b}"
    else:
        return f"{arg:0{wid}b}"

def load_features(file):
    """
        Loading features file and return a list of it 
        features_list
        |-------------->[[individual 1], [individual 2], ..., [individual n]]
        [individual x]->[com 0, com 1, ..., com n]
        com x         -> string encodes
    """
    features = []
    with open (r"%s"%(file), "r") as f:
        reader = csv.reader(f)
        for row in reader:
            features.append(row)
    return features

class Approximate_Compressor_Generate(object):

    """
        Generate approximate compressors by features
    """

    def __init__(self):
        print("generate approximate multiplier")

    def verilog_gen(self, width, num, feature_index):
        """
            use compressor encode generate corresponding code
        """
        comp_encode = dec2bin(num, 2**width)
        input_sig = ["a", "b", "c", "d"]
        case_sig = r"{"
        for i in range(width):
            if i==width-1:
                case_sig += input_sig[i]
                case_sig += r"}"
            else:
                case_sig += input_sig[i]
                case_sig += r", "
        _str  = "module ap_com_%d_index_%d(\n"%(width, feature_index)
        for i in range(width):
            _str += "\tinput wire %s,\n"%(input_sig[i])
        _str += "\toutput reg y\n"
        _str += ");\n\n"
        _str += "always @(*) begin\n"
        _str += "\tcase(%s)\n"%(case_sig)
        for i in range(2**width):
            # it is correct at all.
            _str += "\t\t%d'b%s: y = %s;\n"%(width, dec2bin(i, width), comp_encode[2**width-1-i]) 
        _str += "\t\tdefault:;\n"
        _str += "\tendcase\n"
        _str += "end\n\n"
        _str += "endmodule\n\n\n"
        return _str

    def write_ap_com(self, features):
        """
            use features write approximate compressors
        """
        _verilog = ""
        for feature_index, feature in enumerate(features):
            _verilog += self.verilog_gen(int(feature[0]), int(feature[1:]), feature_index)
        with open (r"mult_src/ap_com.v", "w") as f:
            f.write(_verilog)


if __name__ == "__main__":
    # multiplier type
    mult_type = "si_wid_12_r_10"
    regx_type = r"(\w+)_wid_(\w+)_r_(\w+)"
    regx_res = re.findall(regx_type, mult_type)
    if len(regx_res) == 0:
        raise ValueError
    else:
        sign = regx_res[0][0]
        width = regx_res[0][1]
        r = regx_res[0][2]
    mult_prj = "./mult_home/ap_%s_wall_%sb_r%s"%(sign, width, r)

    # features files
    feat_file = "./dat/%s/features.csv"%(mult_type)
    features = load_features(feat_file)
    # multiplier number
    mult_num = 2
    mult_src = "mult_src"
    if os.path.exists(mult_src):
        shutil.rmtree(mult_src)
    shutil.copytree(mult_prj, mult_src)
    
    ap_com = Approximate_Compressor_Generate()
    ap_com.write_ap_com(features[mult_num])
    print("finish")

