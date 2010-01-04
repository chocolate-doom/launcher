
CFLAGS=-Wall
LDFLAGS=-framework Cocoa

OBJS= AppController.o \
      Execute.o \
      IWADController.o \
      IWADLocation.o \
      LauncherManager.o \
      main.o

launcher : $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS) -o $@

%.o : %.m
	$(CC) -c $(CFLAGS) $^ -o $@

clean :
	rm -f $(OBJS) launcher

