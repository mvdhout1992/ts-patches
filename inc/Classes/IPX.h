typedef struct IPXGlobalConnClass IPXGlobalConnClass;
#pragma pack(push, 1)
typedef struct IPXManagerClass
{
  int field_0;
  char ConnectionAlive;
  char field_5;
  char gap_6[2];
  int field_8;
  int field_C;
  int field_10;
  int field_14;
  __int16 field_18;
  __int16 field_1A;
  int field_1C;
  IPXGlobalConnClass *ConnectionArray[7];
  int NumConnections;
  int IPXGlobalConnClass;
  int field_44;
  int RetryDelta;
  int field_4C;
  int RetryTimeOut;
  int field_54;
  int IPXHeader;
  int field_5C;
  int field_60;
  int field_64;
  int field_68;
  int field_6C;
  int field_70;
  int field_74;
  int field_78;
  int IPXHeader2;
} IPXManagerClass;
#pragma pack(pop)

typedef struct ConnectionClass ConnectionClass;

#pragma pack(push, 1)
typedef struct IPXGlobalConnClass
{
  char field_0;
  char field_1;
  char field_2;
  char field_3;
  ConnectionClass *CommBufferClass;
  int32_t Resends;
  int32_t NumLost;
  int32_t PercentLost;
  char field_14;
  char field_15;
  char field_16;
  char field_17;
  char field_18;
  char field_19;
  char field_1A;
  char field_1B;
  int32_t field_1C;
  int32_t field_20;
  int32_t field_24;
  int32_t RetryDelta;
  char field_2C;
  char field_2D;
  char field_2E;
  char field_2F;
  int32_t RetryTimeOut;
  char field_34;
  char field_35;
  char field_36;
  char field_37;
  char field_38;
  char field_39;
  char field_3A;
  char field_3B;
  char field_3C;
  char field_3D;
  char field_3E;
  char field_3F;
  char field_40;
  char field_41;
  char field_42;
  char field_43;
  char field_44;
  char field_45;
  char field_46;
  char field_47;
  char field_48;
  char field_49;
  char field_4A;
  char field_4B;
  char Address;
  char field_4D;
  char field_4E;
  char field_4F;
  char field_50;
  char field_51;
  char field_52;
  char field_53;
  char field_54;
  char field_55;
  char field_56;
  char field_57;
  char field_58;
  char field_59;
  char field_5A;
  char field_5B;
  char field_5C;
  char field_5D;
  char field_5E;
  char field_5F;
  int32_t ID;
  char Name[9];
  char field_6D;
  char field_6E;
  char field_6F;
  char field_70;
  char field_71;
  char field_72;
  char field_73;
  char field_74;
  char field_75;
  char field_76;
  char field_77;
  char field_78;
  char field_79;
  char field_7A;
  char field_7B;
  char field_7C;
  char field_7D;
  char field_7E;
  char field_7F;
  char field_80;
  char field_81;
  char field_82;
  char field_83;
  char field_84;
  char field_85;
  char field_86;
  char field_87;
  char field_88;
  char field_89;
  char field_8A;
  char field_8B;
  char field_8C;
  char field_8D;
  char field_8E;
  char field_8F;
  char field_90;
  char field_91;
  char field_92;
  char field_93;
  char field_94;
  char field_95;
  char field_96;
  char field_97;
  char field_98;
  char field_99;
  char field_9A;
  char field_9B;
  char field_9C;
  char field_9D;
  char field_9E;
  char field_9F;
  char field_A0;
  char field_A1;
  char field_A2;
  char field_A3;
  char field_A4;
  char field_A5;
  char field_A6;
  char field_A7;
  char field_A8;
  char field_A9;
  char field_AA;
  char field_AB;
} IPXGlobalConnClass;
#pragma pack(pop)

#pragma pack(push, 1)
struct ConnectionClass
{
  int vt;
  int field_4;
  int field_8;
  int field_C;
  int field_10;
  int field_14;
  int field_18;
  int32_t AverageResponseTime;
  int32_t MaxResponseTime;
  int16_t PcktGameID;
  char field_26;
  char field_27;
  int field_28;
  int field_2C;
};
#pragma pack(pop)

extern IPXManagerClass IPXManagerClass_this;
int32_t __thiscall  IPXManagerClass__Response_Time(IPXManagerClass *ipx);
void Send_Response_Time();
